#!/usr/bin/env bash
set -euo pipefail

DATE=$(date +"%F_%H-%M")
BACKUP_DIR="/backup/paperless"
SOURCE_DIR="/opt/stacks/paperless/paperless-ngx"

mkdir -p "$BACKUP_DIR"

tar czf "$BACKUP_DIR/paperless_files_${DATE}.tar.gz" -C "$SOURCE_DIR" consume data media export
