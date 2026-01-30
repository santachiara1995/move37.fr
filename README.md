# template-vps

Minimal Vue + Vite frontend with a Bun + Elysia backend. Deploys automatically on push to `master` using GitHub Actions + Tailscale SSH.

## Local development

Backend:

```bash
cd backend
bun install
bun run dev
```

Frontend:

```bash
cd frontend
bun install
bun run dev
```

## Docker (local or VPS)

Build and run both services:

```bash
docker compose up --build
```

- Web: `http://localhost:8080`
- API: `http://localhost:3000/api/health`
- Adminer: `http://localhost:8081`
- SQLite file: `data/app.db`

## Auto-deploy (current flow)

Deploy happens on every push to `master` via GitHub Actions. The workflow:

- connects to Tailscale
- SSHes to the VPS
- pulls the repo
- rebuilds containers with `docker compose up -d --build`

File: `.github/workflows/deploy.yml`

## Required GitHub secrets

- `TAILSCALE_AUTH_KEY`
- `SSH_PRIVATE_KEY` (full private key block, no passphrase)

## Systemd (auto-start on reboot)

```bash
chmod +x scripts/install-systemd.sh
sudo ./scripts/install-systemd.sh
```

## Environment

- Backend example: `backend/.env.example`
- Frontend example: `frontend/.env.example`
