#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME=${SERVICE_NAME:-template-vps}
APP_DIR=${APP_DIR:-/home/didi/Desktop/template-vps}
UNIT_PATH=/etc/systemd/system/${SERVICE_NAME}.service

if [[ ! -d "$APP_DIR" ]]; then
  echo "App directory not found: $APP_DIR"
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found. Install Docker first."
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "docker compose not found. Install Docker Compose first."
  exit 1
fi

echo "Writing systemd unit: $UNIT_PATH"
sudo tee "$UNIT_PATH" >/dev/null <<EOF
[Unit]
Description=Template VPS Docker Compose Stack
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
WorkingDirectory=$APP_DIR
ExecStart=/usr/bin/docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
ExecStop=/usr/bin/docker compose -f docker-compose.yml -f docker-compose.prod.yml down
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_NAME"

echo "Service enabled: $SERVICE_NAME"
sudo systemctl status "$SERVICE_NAME" --no-pager
