# Agent Guide (template-vps)

This file is for automated coding agents working in this repository.
Follow the commands and conventions below.

## Repo overview

- `backend/`: Bun + Elysia API (SQLite).
- `frontend/`: Vue + Vite app (static build served by nginx).
- `docker-compose.yml`: local/dev builds on the VPS.
- `docker-compose.prod.yml`: prebuilt images (GHCR) when used.
- `.github/workflows/deploy.yml`: SSH deploy over Tailscale.

## Build / dev / test commands

### Backend (Bun)

- Install deps:
  - `cd backend && bun install`
- Dev server (watch):
  - `cd backend && bun run dev`
- Start (prod):
  - `cd backend && bun run start`
- Tests:
  - Not configured. `bun run test` exits with error.
  - Add tests before invoking test commands.

### Frontend (Vue + Vite)

- Install deps:
  - `cd frontend && bun install`
- Dev server:
  - `cd frontend && bun run dev`
- Build:
  - `cd frontend && bun run build`
- Preview build:
  - `cd frontend && bun run preview`
- Tests / lint:
  - Not configured.

### Docker (root)

- Build + run:
  - `docker compose up --build`
- Rebuild after deploy pull:
  - `docker compose up -d --build`
- With GHCR images (optional):
  - `docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d`

## Single test guidance

There is no test runner configured. If tests are added later, document here:
- How to run a single test file or test name.

## Code style guidelines

### General

- Use ASCII text unless a file already uses Unicode.
- Keep changes minimal and focused.
- Do not add comments unless a block is non-obvious.
- Prefer explicit naming over abbreviations.
- Keep error messages short and user-friendly.

### JavaScript / TypeScript

- Use `const` by default; use `let` only when reassigned.
- Prefer `async/await` over chained promises.
- Use early returns for error cases.
- Avoid implicit type coercion; be explicit.

### Vue (frontend)

- Use `<script setup>` when needed; omit if no script is required.
- Keep components small and focused.
- Use kebab-case for component names in templates.
- Keep template markup simple; avoid deeply nested structures.
- Keep styles in `frontend/src/assets/main.css` for global styles.
- Avoid introducing heavy UI patterns unless requested.

### Elysia (backend)

- Use the Elysia instance pattern in `backend/src/index.ts`.
- Validate inputs with `t.Object` when accepting bodies/params.
- Return JSON objects for API responses.
- Use `set.status` for non-200 responses.

### SQLite usage

- Use parameterized queries.
- Keep SQL in single-line strings for simple statements.
- Avoid long multi-statement transactions unless needed.

### Naming conventions

- Files: `kebab-case` for new files unless adjacent files differ.
- Variables: `camelCase`.
- Constants: `UPPER_SNAKE_CASE` only for true constants.
- CSS classes: `kebab-case`.

### Imports

- Order: external libs first, then local files.
- Prefer named imports when available.
- Avoid unused imports.

### Formatting

- Match existing formatting in each file.
- Use 2-space indentation in Vue and CSS.
- Keep lines reasonably short (< 100 chars) when possible.

### Error handling

- Backend: return `{ error: "message" }` for client errors.
- Frontend: show a simple message; avoid alert() unless requested.
- Log server errors only when needed to debug.

## Environment and configuration

- Backend env example: `backend/.env.example`
- Frontend env example: `frontend/.env.example`
- Frontend build-time variable: `VITE_API_URL`

## CI/CD and deployment notes

- Default branch: `master`.
- Deploy workflow uses Tailscale + SSH.
- Deploy command runs `docker compose up -d --build`.
- Ensure GitHub secrets:
  - `TAILSCALE_AUTH_KEY`
  - `SSH_PRIVATE_KEY` (full private key block, no passphrase)

## Repo rules from other tools

- No `.cursor/rules`, `.cursorrules`, or Copilot instructions were found.
- If added later, update this file to reflect them.
