#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME=${SERVICE_NAME:-template-vps-webhook}
APP_DIR=${APP_DIR:-/home/didi/Desktop/template-vps}
UNIT_PATH=/etc/systemd/system/${SERVICE_NAME}.service
SNIPPET_PATH=/etc/nginx/snippets/template-vps-webhook.conf
ENV_PATH=/etc/template-vps/webhook.env

WEBHOOK_SECRET=${WEBHOOK_SECRET:-}
HOST=${HOST:-127.0.0.1}
PORT=${PORT:-9000}
DEPLOY_CMD=${DEPLOY_CMD:-$APP_DIR/scripts/deploy-pull.sh}

if [[ -z "$WEBHOOK_SECRET" ]]; then
  echo "WEBHOOK_SECRET is required"
  exit 1
fi

if [[ ! -d "$APP_DIR" ]]; then
  echo "App directory not found: $APP_DIR"
  exit 1
fi

if ! command -v bun >/dev/null 2>&1; then
  echo "bun not found. Install Bun on the VPS."
  exit 1
fi

echo "Writing webhook env: $ENV_PATH"
sudo mkdir -p /etc/template-vps
sudo tee "$ENV_PATH" >/dev/null <<EOF
WEBHOOK_SECRET=$WEBHOOK_SECRET
HOST=$HOST
PORT=$PORT
DEPLOY_CMD=$DEPLOY_CMD
EOF

echo "Writing webhook systemd unit: $UNIT_PATH"
sudo tee "$UNIT_PATH" >/dev/null <<EOF
[Unit]
Description=Template VPS GitHub Webhook Listener
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
EnvironmentFile=$ENV_PATH
WorkingDirectory=$APP_DIR
ExecStart=/usr/bin/bun $APP_DIR/scripts/webhook-server.js
Restart=on-failure
RestartSec=2s

[Install]
WantedBy=multi-user.target
EOF

echo "Writing nginx snippet: $SNIPPET_PATH"
sudo mkdir -p /etc/nginx/snippets
sudo tee "$SNIPPET_PATH" >/dev/null <<EOF
location /_deploy {
  proxy_pass http://$HOST:$PORT;
  proxy_http_version 1.1;
  proxy_set_header Host \$host;
  proxy_set_header X-Real-IP \$remote_addr;
  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto \$scheme;
}
EOF

echo "Add this line inside your nginx server block if it is not already there:"
echo "  include /etc/nginx/snippets/template-vps-webhook.conf;"

sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_NAME"
sudo systemctl status "$SERVICE_NAME" --no-pager
