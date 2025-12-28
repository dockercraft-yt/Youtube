#!/usr/bin/env bash
set -euo pipefail

DATE=$(date +"%F_%H-%M")
STACK_DIR="/opt/stacks/paperless"
BACKUP_DIR="/backup/config"

COMPOSE_FILE="compose.yaml"
ENV_FILE=".env"

mkdir -p "$BACKUP_DIR"

ARCHIVE="${BACKUP_DIR}/paperless_config_${DATE}.tar.gz"

echo "Sichere Compose & Env …"

cd "$STACK_DIR"

# Safety checks
[[ -f "$COMPOSE_FILE" ]] || { echo "FEHLER: $COMPOSE_FILE nicht gefunden"; exit 1; }
[[ -f "$ENV_FILE" ]]     || { echo "FEHLER: $ENV_FILE nicht gefunden"; exit 1; }

tar -czf "$ARCHIVE" \
  "$COMPOSE_FILE" \
  "$ENV_FILE"

echo "Config-Backup abgeschlossen: $ARCHIVE"
