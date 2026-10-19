# Runbook Operasional - PBL SOC 310

## Struktur Deployment (Terbaru)
| Zona | VM | Service |
|------|-----|---------|
| DMZ | VM 1 (zaid@zaid) | Nginx (WAF + LB), Web Flask (web1 & web2) |
| Internal | VM 1 (Titip) | MySQL (Port 3306 terbuka) |
| Backup | VM 2 (zaid@backup) | Nxs-backup |

## Cara Jalanin Environment DMZ
```bash
cd ~/pbl-soc-310/infra
docker compose up -d
