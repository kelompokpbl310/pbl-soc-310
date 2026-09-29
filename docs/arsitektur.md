
# Arsitektur Sistem

## Zona Jaringan
| Zona | VLAN | Isi |
|------|------|-----|
| DMZ | 10 | Nginx + ModSecurity (WAF) |
| Internal | 20 | Flask, MySQL |
| SOC | 30 | Wazuh, TheHive, MISP |
| Backup | 40 | Nxs-backup |

## Alur Data
User -> Internet -> Firewall -> DMZ (WAF) -> Internal (Flask) -> MySQL

## Alur Log
Semua zona -> Wazuh (SIEM) -> TheHive -> Discord/Telegram

## Network Docker
- dmz-net : WAF
- int-net : Web, MySQL
- soc-net : Wazuh

