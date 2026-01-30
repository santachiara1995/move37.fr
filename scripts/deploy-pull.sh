#!/usr/bin/env bash
set -euo pipefail

APP_DIR=${APP_DIR:-/home/didi/Desktop/template-vps}
REGISTRY=${REGISTRY:-ghcr.io}
IMAGE_NAMESPACE=${IMAGE_NAMESPACE:-santachiara1995/template-vps}
TOKEN_FILE=${TOKEN_FILE:-/etc/template-vps/ghcr.env}

if [[ ! -d "$APP_DIR" ]]; then
  echo "App directory not found: $APP_DIR"
  exit 1
fi

if [[ ! -f "$TOKEN_FILE" ]]; then
  echo "Token file not found: $TOKEN_FILE"
  echo "Create it with: sudo mkdir -p /etc/template-vps && sudo tee $TOKEN_FILE"
  exit 1
fi

set -a
source "$TOKEN_FILE"
set +a

if [[ -z "${GHCR_TOKEN:-}" ]]; then
  echo "GHCR_TOKEN is missing in $TOKEN_FILE"
  exit 1
fi

echo "Logging into $REGISTRY"
echo "$GHCR_TOKEN" | docker login "$REGISTRY" -u "${GHCR_USER:-santachiara1995}" --password-stdin

echo "Pulling latest images"
docker pull "$REGISTRY/$IMAGE_NAMESPACE/api:latest"
docker pull "$REGISTRY/$IMAGE_NAMESPACE/web:latest"

echo "Starting stack"
cd "$APP_DIR"
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
