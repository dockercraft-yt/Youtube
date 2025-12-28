#!/usr/bin/env bash
set -euo pipefail

STACK_DIR="/opt/stacks/paperless"
LOG_DIR="/backup/logs"
LOG="${LOG_DIR}/backup_$(date +%F).log"

mkdir -p "$LOG_DIR"

{
  echo "========================================"
  echo "Backup gestartet: $(date)"
  echo "========================================"

  echo "[1/5] PostgreSQL Backup"
  /root/scripts/backup/backup_postgres.sh

  #Optional
  echo "[2/5] Paperless-Dateien Backup / Dateien"
  /root/scripts/backup/backup_paperless_files.sh

  echo "[3/5] Paperless-Dateien Backup / Export"
  /root/scripts/backup/backup_paperless_export.sh

  echo "[4/5] Paperless-NGX Compose und .env Backup"
  /root/scripts/backup/backup_config.sh

  echo "[5/5] Retention Cleanup"
  /root/scripts/backup/cleanup_retention.sh
  
  echo "========================================"
  echo "Backup erfolgreich beendet"
  echo "========================================"
} >> "$LOG" 2>&1


