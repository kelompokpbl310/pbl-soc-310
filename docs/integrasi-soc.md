# Panduan Integrasi Log ke SOC (Untuk Tim Wazuh)

Halo Tim SOC (Regynda dkk), berikut adalah informasi sumber daya dari sisi DevOps (DMZ & Backup) yang siap ditarik log-nya ke Wazuh Manager.

## 1. VM Backup (Nxs-Backup)
- **IP Address:** `192.168.249.128` (Sesuaikan jika IP berubah)
- **Fungsi:** Menjalankan backup database MySQL secara terjadwal dari VM DMZ.
- **Path Log Utama:** 
  `/var/log/nxs-backup/nxs-backup.log`
- **Format Log:** Plain text. Log akan berisi status `Backup starting`, `Backup finished` (sukses), atau error koneksi jika backup gagal.
- **Path File Backup:** 
  `/var/nxs-backup/dump/databases/mysql_db/toko/daily/`

**Cara Integrasi:** 
Instal Wazuh Agent di dalam VM Backup ini, lalu tambahkan konfigurasi `<localfile>` di `/var/ossec/etc/ossec.conf` untuk membaca file log di atas.

## 2. VM DMZ (Nginx WAF & Web Server)
- **IP Address:** `192.168.249.129`
- **Fungsi:** Menjalankan Nginx (WAF+LB), Web Flask (web1 & web2), dan MySQL.
- **Path Log Nginx (Akses & Error):**
  Log tersimpan di dalam container. Bisa diakses dari host menggunakan perintah:
  `docker compose logs nginx > /var/log/nginx-dmz.log`
- **Path Log ModSecurity (WAF):**
  ModSecurity mencatat serangan SQLi/XSS dalam format JSON di log error Nginx.

## 3. Metrik yang Bisa Dibuat di Wazuh
- **Alert Kritis:** Jika di `nxs-backup.log` muncul kata `error` atau `failed`.
- **Alert WAF:** Jika ModSecurity mendeteksi dan memblokir request (HTTP 403).
- **Alert Anti-DDoS:** Jika Nginx melakukan Rate Limiting (HTTP 503).

---
*Silakan hubungi Zaid (DevOps) jika butuh akses SSH atau ada penyesuaian IP.*
