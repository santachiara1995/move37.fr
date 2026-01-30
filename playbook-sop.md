# Multi-Site Deployment Playbook (SOP)

## Goal
Clone this template, change a few lines, and deploy to multiple domains with the same CI/CD flow.

Domains:
- lsllearning.com
- kathello.fr
- cityzfrance.fr
- fabulousparis.com
- sereniteformation.org

---

## A) One-time VPS setup

1) Install core services
- Tailscale
- Docker + Docker Compose
- nginx
- certbot

2) Create site folder root

```
sudo mkdir -p /srv/sites
sudo chown -R $USER:$USER /srv/sites
```

3) Confirm Tailscale IP

```
tailscale ip -4
```

4) Keep SSH closed to the public
- SSH only via Tailscale
- Firewall blocks port 22 externally

---

## B) Create a new site (repeat per domain)

### 1) Create the repo from template

Option A: GitHub “Use this template”
- New repo name: `site-domain`

Option B: Clone and push to new repo

```
git clone https://github.com/santachiara1995/template-vps.git site-domain
cd site-domain
git remote set-url origin https://github.com/santachiara1995/NEW_REPO.git
git push -u origin master
```

### 2) Set repo secrets

Required secrets for each repo:
- `TAILSCALE_AUTH_KEY`
- `SSH_PRIVATE_KEY` (full private key block, no passphrase)

### 3) Update deploy workflow values

File: `.github/workflows/deploy.yml`

Set:
- VPS Tailscale IP
- SSH user (e.g., `didi`)
- Repo folder path on VPS

### 4) Create VPS folder and clone

```
cd /srv/sites
git clone https://github.com/santachiara1995/NEW_REPO.git site-domain
```

### 5) Configure nginx site

Create a new nginx site file per domain:

```
sudo nano /etc/nginx/sites-available/site-domain
```

Example template:

```
server {
  listen 80;
  server_name yourdomain.com;

  location / {
    proxy_pass http://127.0.0.1:PORT;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
}
```

Enable site:

```
sudo ln -s /etc/nginx/sites-available/site-domain /etc/nginx/sites-enabled/site-domain
sudo nginx -t
sudo systemctl reload nginx
```

### 6) Issue TLS cert

```
sudo certbot --nginx -d yourdomain.com -m you@example.com --agree-tos --non-interactive
```

---

## C) Compose setup per site

Each site should use a unique port mapping in `docker-compose.yml`:

```
web:
  ports:
    - "8081:80"
```

Pick a different port for every site:
- lsllearning.com -> 8081
- kathello.fr -> 8082
- cityzfrance.fr -> 8083
- fabulousparis.com -> 8084
- sereniteformation.org -> 8085

Update nginx `proxy_pass` to match the site’s port.

---

## D) Deploy flow (per site)

1) Work on your laptop in a branch
2) Push branch
3) Open PR and merge to `master`
4) GitHub Actions deploys to VPS
5) VPS runs:

```
git pull origin master
docker compose up -d --build
```

---

## E) Quick verification checklist

- GitHub Actions → Deploy job successful
- `https://domain` shows updated content
- `docker ps` shows the containers running
- `sudo nginx -t` passes

---

## Notes and best practices

- Use a dedicated deploy key per repo if possible.
- `SSH_PRIVATE_KEY` must be the full private key block.
- Do not use passphrase-protected keys in CI.
- Rebuild on deploy if not using GHCR.
