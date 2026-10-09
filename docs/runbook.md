# Runbook Operasional

## Struktur Deployment

| Zona | VM | Service |
|------|-----|---------|
| DMZ | VM 1 | Nginx (WAF + Load Balancer), Web Flask |
| Internal | VM 2 (belum) | MySQL (titip di DMZ sementara) |
| SOC | VM 3 (belum) | Wazuh, TheHive, MISP |
| Backup | VM 4 (belum) | Nxs-backup |

---

## Cara Jalanin

```bash
cd ~/pbl-soc-310/infra
docker compose up -d