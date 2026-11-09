#!/bin/bash

# 1. Cek update Repo Utama (Infrastruktur)
cd /home/zaid/pbl-soc-310 || exit
OLD_COMMIT_MAIN=$(git rev-parse HEAD)
git pull origin main
NEW_COMMIT_MAIN=$(git rev-parse HEAD)

# 2. Tarik Paksa Update dari Repo Arys (Selalu Clone Ulang)
cd /tmp
rm -rf pbl310
git clone https://github.com/kelompokpbl310/pbl310.git
cd pbl310
NEW_COMMIT_ARYS=$(git rev-parse HEAD)

# 3. Bandingin kode Arys (pakai MD5 hash file __init__.py)
OLD_HASH=$(md5sum /home/zaid/pbl-soc-310/backend/app/__init__.py 2>/dev/null | awk '{print $1}')
NEW_HASH=$(md5sum /tmp/pbl310/app/__init__.py | awk '{print $1}')

# 4. Copy kode terbaru ke folder backend
cp -r /tmp/pbl310/app /home/zaid/pbl-soc-310/backend/
cp /tmp/pbl310/run.py /home/zaid/pbl-soc-310/backend/ 2>/dev/null
cp /tmp/pbl310/package.json /home/zaid/pbl-soc-310/backend/ 2>/dev/null
cp /tmp/pbl310/input.css /home/zaid/pbl-soc-310/backend/ 2>/dev/null

# 5. Cek apakah ada update dan Rebuild
cd /home/zaid/pbl-soc-310 || exit

if [ "$OLD_COMMIT_MAIN" == "$NEW_COMMIT_MAIN" ] && [ "$OLD_HASH" == "$NEW_HASH" ]; then
    echo "[$(date)] Tidak ada update dari Repo Utama maupun Repo Arys."
else
    echo "[$(date)] Ada update terdeteksi! Memulai rebuild Docker..."
    cd infra
    docker compose build --no-cache web web2
    docker compose up -d web web2
    echo "[$(date)] Deploy selesai!"
fi
