import { createHmac, timingSafeEqual } from "node:crypto";

const host = process.env.HOST ?? "127.0.0.1";
const port = Number(process.env.PORT ?? 9000);
const secret = process.env.WEBHOOK_SECRET ?? "";
const deployCmd =
  process.env.DEPLOY_CMD ??
  "/home/didi/Desktop/template-vps/scripts/deploy-pull.sh";

if (!secret) {
  console.error("WEBHOOK_SECRET is required");
  process.exit(1);
}

let deploying = false;

const verifySignature = async (req, bodyText) => {
  const signature = req.headers.get("x-hub-signature-256");
  if (!signature || !signature.startsWith("sha256=")) return false;

  const expected = createHmac("sha256", secret)
    .update(bodyText)
    .digest("hex");
  const actual = signature.slice("sha256=".length);

  if (expected.length !== actual.length) return false;

  return timingSafeEqual(Buffer.from(expected), Buffer.from(actual));
};

const server = Bun.serve({
  hostname: host,
  port,
  async fetch(req) {
    const url = new URL(req.url);
    if (req.method !== "POST" || url.pathname !== "/_deploy") {
      return new Response("Not found", { status: 404 });
    }

    const bodyText = await req.text();
    const valid = await verifySignature(req, bodyText);
    if (!valid) return new Response("Invalid signature", { status: 401 });

    const event = req.headers.get("x-github-event");
    if (event !== "push") {
      return new Response("Ignored", { status: 202 });
    }

    let payload;
    try {
      payload = JSON.parse(bodyText);
    } catch (err) {
      return new Response("Invalid JSON", { status: 400 });
    }

    if (payload.ref !== "refs/heads/main") {
      return new Response("Ignored", { status: 202 });
    }

    if (deploying) {
      return new Response("Deploy already running", { status: 202 });
    }

    deploying = true;
    Bun.spawn(["/bin/bash", "-lc", deployCmd], {
      stdout: "inherit",
      stderr: "inherit"
    }).exited.then(() => {
      deploying = false;
    });

    return new Response("Deploy started", { status: 202 });
  }
});

console.log(`Webhook listener on http://${server.hostname}:${server.port}`);
