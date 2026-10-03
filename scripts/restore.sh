#!/bin/bash

# ================================
# Script Restore MySQL - PBL SOC 310
# ================================

if [ -z "$1" ]; then
    echo "Usage: ./restore.sh <file_backup.sql>"
    exit 1
fi

BACKUP_FILE="$1"
CONTAINER="mysql-db"
DB_NAME="toko"
DB_USER="root"
DB_PASS="mmk"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "File tidak ditemukan: $BACKUP_FILE"
    exit 1
fi

echo "[$(date)] Mulai restore dari: $BACKUP_FILE"
docker exec -i "$CONTAINER" mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date)] Restore berhasil!"
else
    echo "[$(date)] Restore GAGAL!"
    exit 1
fi