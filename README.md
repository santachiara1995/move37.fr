# template-vps

Vue + Vite front-end with a Bun + Elysia API backed by SQLite.

## Local development

API:

```bash
cd backend
bun install
bun run dev
```

Web:

```bash
cd frontend
bun install
bun run dev
```

Set `VITE_API_URL` for the web app if the API is not on `https://move37.online`.

## Docker

Build and run both services:

```bash
docker compose up --build
```

- Web: `http://localhost:8080`
- API: `http://localhost:3000/api/health`
- Adminer (DB viewer): `http://localhost:8081`
- SQLite file: `data/app.db`

The web container uses nginx inside Docker. No host nginx install is required.

## Systemd (auto-start)

```bash
chmod +x scripts/install-systemd.sh
sudo ./scripts/install-systemd.sh
```

## Auto-deploy on merge (GHCR pull)

1) Create a GitHub token with `read:packages` and `repo` (private repo) and put it on the VPS:

```bash
sudo mkdir -p /etc/template-vps
sudo tee /etc/template-vps/ghcr.env >/dev/null <<EOF
GHCR_USER=santachiara1995
GHCR_TOKEN=YOUR_TOKEN_HERE
EOF
```

2) Install the deploy timer:

```bash
chmod +x scripts/deploy-pull.sh scripts/install-deploy-timer.sh
sudo ./scripts/install-deploy-timer.sh
```

The timer pulls `ghcr.io/santachiara1995/template-vps/{api,web}:latest` every 5 minutes and restarts the stack.

Production uses `docker-compose.prod.yml` (prebuilt images) layered on top of `docker-compose.yml`.
Re-run `scripts/install-systemd.sh` if you want systemd to use the prod compose file.

## Instant deploy via GitHub webhook (recommended)

1) Install the webhook listener on the VPS:

```bash
chmod +x scripts/install-webhook.sh
WEBHOOK_SECRET=YOUR_SECRET_HERE sudo ./scripts/install-webhook.sh
```

2) Add the webhook in GitHub:

- URL: `https://move37.online/_deploy`
- Content type: `application/json`
- Secret: `YOUR_SECRET_HERE`
- Events: `Just the push event`

Now, merges to `main` trigger an immediate deploy.

## Environment

- API example: `backend/.env.example`
- Web example: `frontend/.env.example`

## CI/CD

GitHub Actions builds Docker images and pushes to GHCR on `master`.
Update the `VITE_API_URL` build arg in `.github/workflows/ci.yml` for your deploy URL.
