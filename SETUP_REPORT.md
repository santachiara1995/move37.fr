# Move37 VPS Template - Setup Report

This report documents the full end-to-end setup of the Move37 VPS template: repo structure, Docker, nginx/TLS, and the Tailscale-based CI/CD flow.

## 1) Repository structure

```
/backend
  src/index.ts
  package.json
  bun.lock
  Dockerfile
/frontend
  src/App.vue
  src/assets/main.css
  package.json
  bun.lock
  Dockerfile
  nginx.conf
docker-compose.yml
docker-compose.prod.yml
.github/workflows/ci.yml
.github/workflows/deploy.yml
scripts/
```

Purpose:
- `backend/` holds the Bun + Elysia API.
- `frontend/` holds the Vue + Vite app.
- `docker-compose.yml` builds on the VPS.
- `docker-compose.prod.yml` can be used with prebuilt images (GHCR).
- `.github/workflows/deploy.yml` handles automated deployment.

## 2) Frontend and backend behavior

Frontend:
- Current landing page is a simple message: "Welcome to the Move 37 universe."

Backend:
- Elysia API with SQLite.
- Health endpoint: `/api/health`.
- SQLite database path: `data/app.db`.

## 3) Docker and compose

Two containers are used:
- `web`: nginx serving the built Vue app.
- `api`: Bun + Elysia API.

Local build on VPS (current deployment flow):

```
docker compose up -d --build
```

This builds containers from the latest code pulled onto the VPS.

## 4) nginx + TLS

Host nginx terminates TLS and proxies:

- `/` -> web container (port 8080)
- `/api/` -> api container (port 3000)

TLS is managed by Certbot (Let's Encrypt).

## 5) Systemd

Systemd unit was installed to auto-start the stack after reboot.

Location:

```
/etc/systemd/system/template-vps.service
```

ExecStart:

```
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

## 6) CI/CD with GitHub Actions + Tailscale + SSH

We chose SSH deploy over GHCR because the repo is private and we did not want a GHCR token on the VPS.

Deploy flow:

1) Push/merge to `master`.
2) GitHub Actions joins Tailscale.
3) GitHub Actions SSHes to the VPS using the Tailscale IP.
4) VPS runs:

```
git pull origin master
docker compose pull || true
docker compose up -d --build
```

The `--build` is required because we are not pulling prebuilt images from GHCR.

Workflow file:

```
.github/workflows/deploy.yml
```

### Required GitHub secrets

- `TAILSCALE_AUTH_KEY`: a Tailscale auth key (ephemeral/reusable).
- `SSH_PRIVATE_KEY`: full private key block (unencrypted).

### SSH key requirements

GitHub needs the private key in full, including header/footer:

```
-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
```

This key must NOT have a passphrase.

The matching public key must be in:

```
~/.ssh/authorized_keys
```

Permissions:

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## 7) Why deploys initially did not update

We originally ran:

```
docker compose pull
docker compose up -d
```

Because GHCR was not being used, nothing new was pulled, so the containers did not change.

Fix:

```
docker compose up -d --build
```

## 8) Recommended future pattern

For each repo:
- Use a dedicated SSH deploy key (no passphrase).
- Add its public key to VPS `authorized_keys`.
- Store its private key in `SSH_PRIVATE_KEY` GitHub secret.
- Use Tailscale IP in the workflow.

If you later want faster deploys and reproducible builds, switch to GHCR and pull images instead of building on the VPS.
