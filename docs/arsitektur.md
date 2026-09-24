# Arsitektur Sistem

## Zona Jaringan
| Zona | VLAN | Isi |
|------|------|-----|
| DMZ | 10 | Nginx + ModSecurity |
| Internal | 20 | Flask, MySQL, MinIO |
| SOC | 30 | Wazuh, TheHive, MISP |
| Backup | 40 | Nxs-backup |
