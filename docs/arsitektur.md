# Arsitektur Sistem

## Zona Jaringan
| Zona | VLAN | Isi |
|------|------|-----|
| DMZ | 10 | Nginx (WAF + Load Balancer) + Web Server (Flask) |
| Internal | 20 | MySQL |
| SOC | 30 | Wazuh, TheHive, MISP |
| Backup | 40 | Nxs-backup |

## Alur Data
User -> Internet -> OPNsense -> Nginx DMZ (WAF + LB) -> Web Flask -> MySQL

## Catatan Arsitektur
- Web server diletakkan di DMZ karena diakses langsung oleh user.
- Nginx di DMZ berfungsi ganda: WAF (ModSecurity) + Load Balancer (upstream).
- Tidak ada reverse proxy terpisah - Nginx handle semuanya.
- Backup diambil dari database (Internal), bukan dari web server.

## Network Docker
- dmz-net : Nginx, Web Flask
- int-net : Web Flask, MySQL
- soc-net : Wazuh

## Penyimpanan File (Foto & Video)
- MySQL: menyimpan metadata + path file
- Volume `uploads_data`: menyimpan file fisik