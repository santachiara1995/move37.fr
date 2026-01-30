#!/usr/bin/env bash
set -euo pipefail

DOMAIN=${DOMAIN:-}
EMAIL=${EMAIL:-}
WEB_PORT=${WEB_PORT:-8080}
API_PORT=${API_PORT:-3000}
NGINX_SITE=${NGINX_SITE:-/etc/nginx/sites-available/vps-template}
NGINX_ENABLED=${NGINX_ENABLED:-/etc/nginx/sites-enabled/vps-template}

if [[ -z "$DOMAIN" || -z "$EMAIL" ]]; then
  echo "Usage: DOMAIN=example.com EMAIL=you@example.com $0"
  exit 1
fi

echo "[1/6] Checking dependencies"
if ! command -v nginx >/dev/null 2>&1; then
  echo "nginx not found. Install it first: sudo apt-get install -y nginx"
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found. Install it first."
  exit 1
fi

if ! command -v docker-compose >/dev/null 2>&1 && ! docker compose version >/dev/null 2>&1; then
  echo "docker compose not found. Install Docker Compose." 
  exit 1
fi

if ! command -v certbot >/dev/null 2>&1; then
  echo "certbot not found. Installing..."
  sudo apt-get update
  sudo apt-get install -y certbot python3-certbot-nginx
fi

echo "[2/6] Writing nginx site"
sudo tee "$NGINX_SITE" >/dev/null <<EOF
server {
  listen 80;
  server_name $DOMAIN;

  location / {
    proxy_pass http://127.0.0.1:${WEB_PORT};
    proxy_http_version 1.1;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
  }

  location /api/ {
    proxy_pass http://127.0.0.1:${API_PORT};
    proxy_http_version 1.1;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
  }
}
EOF

echo "[3/6] Enabling nginx site"
if [[ -f /etc/nginx/sites-enabled/default ]]; then
  sudo rm -f /etc/nginx/sites-enabled/default
fi

sudo ln -sf "$NGINX_SITE" "$NGINX_ENABLED"
sudo nginx -t
sudo systemctl reload nginx

echo "[4/6] Obtaining TLS cert via Let's Encrypt"
sudo certbot --nginx -d "$DOMAIN" -m "$EMAIL" --agree-tos --non-interactive

echo "[5/6] Starting Docker services"
if docker compose version >/dev/null 2>&1; then
  docker compose up -d --build
else
  docker-compose up -d --build
fi

echo "[6/6] Done"
echo "Web: https://$DOMAIN"
echo "API health: https://$DOMAIN/api/health"
