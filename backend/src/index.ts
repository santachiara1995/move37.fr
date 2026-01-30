import { Database } from "bun:sqlite";
import { cors } from "@elysiajs/cors";
import { Elysia, t } from "elysia";
import { mkdir } from "node:fs/promises";
import { dirname } from "node:path";

const port = Number(process.env.PORT ?? 3000);
const dbPath = process.env.DB_PATH ?? "data/app.db";

await mkdir(dirname(dbPath), { recursive: true });

const db = new Database(dbPath);
db.run(`
  create table if not exists notes (
    id integer primary key autoincrement,
    title text not null,
    body text,
    created_at text not null default (datetime('now'))
  )
`);

const listNotes = db.query(
  "select id, title, body, created_at as createdAt from notes order by id desc"
);
const createNote = db.query(
  "insert into notes (title, body) values ($title, $body) returning id, title, body, created_at as createdAt"
);
const deleteNote = db.query("delete from notes where id = $id");

const app = new Elysia()
  .use(cors())
  .get("/api/health", () => ({ ok: true }))
  .get("/api/notes", () => ({ items: listNotes.all() }))
  .post(
    "/api/notes",
    ({ body, set }) => {
      const title = body.title.trim();
      const noteBody = body.body?.trim() ?? "";

      if (!title) {
        set.status = 400;
        return { error: "Title is required" };
      }

      return createNote.get({ title, body: noteBody });
    },
    {
      body: t.Object({
        title: t.String({ minLength: 1, maxLength: 120 }),
        body: t.Optional(t.String({ maxLength: 1000 }))
      })
    }
  )
  .delete(
    "/api/notes/:id",
    ({ params }) => {
      const result = deleteNote.run({ id: Number(params.id) });
      return { deleted: result.changes };
    },
    {
      params: t.Object({
        id: t.Numeric()
      })
    }
  )
  .listen({ port, hostname: "0.0.0.0" });

console.log(`API ready on http://localhost:${app.server?.port}`);
