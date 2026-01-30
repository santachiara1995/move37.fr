#!/usr/bin/env bash
set -euo pipefail

APP_DIR=${APP_DIR:-/home/didi/Desktop/template-vps}
DOMAIN=${DOMAIN:-move37.online}
GHCR_USER=${GHCR_USER:-santachiara1995}
GHCR_TOKEN=${GHCR_TOKEN:-}
WEBHOOK_SECRET=${WEBHOOK_SECRET:-}
NGINX_SITE=${NGINX_SITE:-/etc/nginx/sites-available/vps-template}

if [[ -z "$GHCR_TOKEN" ]]; then
  echo "GHCR_TOKEN is required"
  exit 1
fi

if [[ -z "$WEBHOOK_SECRET" ]]; then
  echo "WEBHOOK_SECRET is required"
  exit 1
fi

if [[ ! -d "$APP_DIR" ]]; then
  echo "App directory not found: $APP_DIR"
  exit 1
fi

echo "[1/5] Writing GHCR token file"
sudo mkdir -p /etc/template-vps
sudo tee /etc/template-vps/ghcr.env >/dev/null <<EOF
GHCR_USER=$GHCR_USER
GHCR_TOKEN=$GHCR_TOKEN
EOF

echo "[2/5] Installing webhook listener"
chmod +x "$APP_DIR/scripts/install-webhook.sh"
WEBHOOK_SECRET="$WEBHOOK_SECRET" sudo "$APP_DIR/scripts/install-webhook.sh"

echo "[3/5] Updating nginx site"
if ! grep -q "template-vps-webhook.conf" "$NGINX_SITE"; then
  sudo tee -a "$NGINX_SITE" >/dev/null <<'EOF'

  include /etc/nginx/snippets/template-vps-webhook.conf;
EOF
fi

sudo nginx -t
sudo systemctl reload nginx

echo "[4/5] Installing deploy timer (backup)"
chmod +x "$APP_DIR/scripts/deploy-pull.sh" "$APP_DIR/scripts/install-deploy-timer.sh"
sudo "$APP_DIR/scripts/install-deploy-timer.sh"

echo "[5/5] Done"
echo "Add GitHub webhook: https://$DOMAIN/_deploy"
