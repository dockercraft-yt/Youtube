#!/usr/bin/env bash
set -euo pipefail

source /root/scripts/backup/retention.conf

cleanup() {
  local path="$1"
  local days="$2"
  local pattern="$3"

  find "$path" -type f -name "$pattern" -mtime +"$days" -print -delete
}

cleanup "/backup/postgres"  "$RETENTION_POSTGRES"  "*.sql.gz"
cleanup "/backup/paperless" "$RETENTION_PAPERLESS" "*.tar.gz"
cleanup "/backup/logs"      "$RETENTION_LOGS"      "*.log"
cleanup "/backup/paperless-export" "$RETENTION_PAPERLESS_EXPORT" "*.tar.gz"
