
# Runbook Operasional

## Deploy
1. Push ke branch feat/*
2. Bikin Pull Request
3. Merge ke main
4. CI/CD deploy otomatis

## Perintah Penting
- Start: docker compose up -d
- Stop: docker compose down
- Cek status: docker compose ps
- Cek log: docker compose logs -f SERVICE
- Restart: docker compose restart SERVICE
- Masuk container: docker exec -it CONTAINER bash

## Troubleshooting
- Container Exited: cek log pakai docker compose logs SERVICE
- Port bentrok: ganti port di docker-compose.yml
- .env gak kebaca: pastikan file ada di folder yang sama

