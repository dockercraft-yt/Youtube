#!/usr/bin/env bash
set -euo pipefail

DATE=$(date +"%F_%H-%M")
BACKUP_DIR="/backup/postgres"

CONTAINER="paperless_db"
DB_NAME="paperless"
DB_USER="paperless"

mkdir -p "$BACKUP_DIR"

docker exec "$CONTAINER" pg_dump -U "$DB_USER" "$DB_NAME" | gzip > "$BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz"
