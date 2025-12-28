#!/usr/bin/env bash
set -euo pipefail

DATE=$(date +"%F_%H-%M")
BACKUP_DIR="/backup/paperless-export"
STACK_DIR="/opt/stacks/paperless"
EXPORT_DIR="/opt/stacks/paperless/paperless-ngx/export"

mkdir -p "$BACKUP_DIR"

echo "Starte Paperless Export..."

cd "$STACK_DIR"

docker compose exec -T paperless-ngx \
  document_exporter \
  /usr/src/paperless/export \
  --no-progress-bar

echo "Export abgeschlossen, archiviere Daten..."

tar czf \
  "$BACKUP_DIR/paperless_export_${DATE}.tar.gz" \
  -C "$EXPORT_DIR" \
  .

echo "Export erfolgreich abgeschlossen"
