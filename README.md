
# PBL SOC 310 - Toko Makanan

Proyek PBL Semester 3 - Rekayasa Keamanan Siber, Politeknik Negeri Batam.

## Tim
- Zaid Fathin Al Faiz (DevOps)
- Arys Apriatna Ananda
- Yayang Ariesty
- Salsabela Maharani
- Regynda Ayudya

## Arsitektur
- DMZ: Nginx + ModSecurity
- Internal: Flask + MySQL
- SOC: Wazuh

## Cara Jalanin
cd infra
cp .env.example .env
docker compose up -d

## Struktur
- backend/ : aplikasi Flask
- infra/ : Docker Compose
- docs/ : dokumentasi

