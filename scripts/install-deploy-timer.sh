#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME=${SERVICE_NAME:-template-vps-deploy}
APP_DIR=${APP_DIR:-/home/didi/Desktop/template-vps}
UNIT_PATH=/etc/systemd/system/${SERVICE_NAME}.service
TIMER_PATH=/etc/systemd/system/${SERVICE_NAME}.timer

if [[ ! -d "$APP_DIR" ]]; then
  echo "App directory not found: $APP_DIR"
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found. Install Docker first."
  exit 1
fi

echo "Writing systemd unit: $UNIT_PATH"
sudo tee "$UNIT_PATH" >/dev/null <<EOF
[Unit]
Description=Pull latest images and deploy
Wants=network-online.target
After=network-online.target docker.service
Requires=docker.service

[Service]
Type=oneshot
WorkingDirectory=$APP_DIR
ExecStart=$APP_DIR/scripts/deploy-pull.sh
EOF

echo "Writing systemd timer: $TIMER_PATH"
sudo tee "$TIMER_PATH" >/dev/null <<EOF
[Unit]
Description=Periodic deploy pull

[Timer]
OnBootSec=2min
OnUnitActiveSec=5min
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_NAME".timer
sudo systemctl status "$SERVICE_NAME".timer --no-pager
