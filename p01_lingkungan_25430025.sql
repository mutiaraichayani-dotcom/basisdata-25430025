-- Praktikum Basis Data
-- NIM: 25430025

-- Mengecek versi MariaDB dan user
SELECT VERSION(), CURRENT_USER();

-- Melihat database
SHOW DATABASES;

-- Mengecek mode SQL
SELECT @@sql_mode;

-- Melihat akun root
SELECT User, Host
FROM mysql.user
WHERE User = 'root';

-- Mengubah password root
-- Password asli tidak ditulis di file
ALTER USER 'root'@'localhost' IDENTIFIED BY '<PASSWORD_ROOT>';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY '<PASSWORD_ROOT>';
ALTER USER 'root'@'::1' IDENTIFIED BY '<PASSWORD_ROOT>';

-- Membuat database praktik
CREATE DATABASE kopma_025
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Membuat akun kerja
CREATE USER 'mhs_025'@'localhost'
IDENTIFIED BY '<PASSWORD_MHS>';

-- Memberikan hak akses
GRANT ALL PRIVILEGES ON kopma_025.* TO 'mhs_025'@'localhost';

-- Mengecek hak akses
SHOW GRANTS FOR 'mhs_025'@'localhost';

-- Melihat database menggunakan akun kerja
SHOW DATABASES;