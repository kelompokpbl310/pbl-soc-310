#!/bin/bash

# ================================
# Script Backup MySQL - PBL SOC 310
# ================================

BACKUP_DIR="$HOME/pbl-soc-310/backups"
CONTAINER="mysql-db"
DB_NAME="toko"
DB_USER="root"
DB_PASS="mmk"
DATE=$(date +%Y%m%d_%H%M%S)
FILENAME="backup_${DB_NAME}_${DATE}.sql"

mkdir -p "$BACKUP_DIR"

echo "[$(date)] Mulai backup database '$DB_NAME'..."
docker exec "$CONTAINER" mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/$FILENAME"

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_DIR/$FILENAME" | cut -f1)
    echo "[$(date)] Backup berhasil: $FILENAME ($SIZE)"
else
    echo "[$(date)] Backup GAGAL!"
    exit 1
fi

find "$BACKUP_DIR" -name "backup_*.sql" -mtime +7 -delete
echo "[$(date)] Backup lama (>7 hari) dibersihkan."