# PBL SOC 310 - Toko Makanan

Proyek PBL Semester 3 - Rekayasa Keamanan Siber, Politeknik Negeri Batam.

## Tim
| Nama | NIM | Peran |
|------|-----|-------|
| Zaid Fathin Al Faiz | 4332501015 | DevOps |
| Arys Apriatna Ananda | 4332501006 | Web |
| Yayang Ariesty | 4332501010 | Network |
| Salsabela Maharani | 4332501013 | SOC |
| Regynda Ayudya | 4332501024 | Defender |

## Arsitektur
- DMZ: Nginx + ModSecurity (WAF)
- Internal: Flask + MySQL
- SOC: Wazuh, TheHive, MISP
- Backup: Nxs-backup

## Cara Jalanin
cd infra
cp .env.example .env
docker compose up -d

Akses: http://IP-VM:8080/health

## Struktur
- backend/ : aplikasi Flask
- infra/ : Docker Compose & konfigurasi
- scripts/ : backup & restore
- docs/ : dokumentasi
- .github/workflows/ : CI/CD

## Fitur DevOps
- Container isolation (3 network: DMZ, Internal, SOC)
- CI/CD GitHub Actions (lint, build, scan)
- Logging driver JSON (max 10MB, 3 file)
- Healthcheck otomatis
- Backup & restore MySQL
- Hardening container (no-new-privileges, resource limit)

## Dokumentasi
- [Arsitektur](docs/arsitektur.md)
- [Runbook](docs/runbook.md)