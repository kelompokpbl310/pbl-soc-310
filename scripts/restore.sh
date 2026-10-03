#!/bin/bash

# ================================
# Script Restore MySQL + Uploads - PBL SOC 310
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

# === 1. Restore MySQL ===
echo "[$(date)] Mulai restore database dari: $BACKUP_FILE"
docker exec -i "$CONTAINER" mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date)] Restore MySQL berhasil!"
else
    echo "[$(date)] Restore MySQL GAGAL!"
    exit 1
fi

# === 2. Restore Uploads (opsional) ===
UPLOAD_FILE="${BACKUP_FILE/backup_${DB_NAME}_/backup_uploads_}"
UPLOAD_FILE="${UPLOAD_FILE%.sql}.tar.gz"

if [ -f "$UPLOAD_FILE" ]; then
    echo "[$(date)] Ditemukan backup uploads: $UPLOAD_FILE"
    docker run --rm \
        -v infra_uploads_data:/data \
        -v "$(dirname "$UPLOAD_FILE")":/backup \
        alpine sh -c "cd /data && tar xzf /backup/$(basename "$UPLOAD_FILE")"
    echo "[$(date)] Restore uploads berhasil!"
else
    echo "[$(date)] Backup uploads tidak ditemukan, hanya restore MySQL."
fi