#!/bin/bash

# ================================
# Script Backup MySQL + Uploads - PBL SOC 310
# ================================

BACKUP_DIR="$HOME/pbl-soc-310/backups"
CONTAINER="mysql-db"
DB_NAME="toko"
DB_USER="root"
DB_PASS="mmk"
DATE=$(date +%Y%m%d_%H%M%S)
SQL_FILE="backup_${DB_NAME}_${DATE}.sql"
UPLOAD_FILE="backup_uploads_${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"

# === 1. Backup MySQL ===
echo "[$(date)] Mulai backup database '$DB_NAME'..."
docker exec "$CONTAINER" mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/$SQL_FILE"

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_DIR/$SQL_FILE" | cut -f1)
    echo "[$(date)] Backup MySQL berhasil: $SQL_FILE ($SIZE)"
else
    echo "[$(date)] Backup MySQL GAGAL!"
    exit 1
fi

# === 2. Backup Uploads (foto & video) ===
echo "[$(date)] Mulai backup uploads (foto & video)..."
docker run --rm \
    -v infra_uploads_data:/data:ro \
    -v "$BACKUP_DIR":/backup \
    alpine tar czf "/backup/$UPLOAD_FILE" -C /data . 2>/dev/null

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_DIR/$UPLOAD_FILE" | cut -f1)
    echo "[$(date)] Backup uploads berhasil: $UPLOAD_FILE ($SIZE)"
else
    echo "[$(date)] Backup uploads dilewati (folder kosong / belum ada file)."
fi

# === 3. Hapus backup lebih dari 7 hari ===
find "$BACKUP_DIR" -name "backup_*.sql" -mtime +7 -delete
find "$BACKUP_DIR" -name "backup_uploads_*.tar.gz" -mtime +7 -delete
echo "[$(date)] Backup lama (>7 hari) dibersihkan."