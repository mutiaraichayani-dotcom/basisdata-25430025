
CREATE DATABASE IF NOT EXISTS kopma_025
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_025'@'localhost'
  IDENTIFIED BY '<password_kerja>';

GRANT ALL PRIVILEGES ON kopma_025.* TO 'mhs_025'@'localhost';

-- Milestone Proyek 1: Klinik
CREATE DATABASE IF NOT EXISTS klinik_025
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_025'@'localhost'
  IDENTIFIED BY '<password_pengembangan>';

GRANT ALL PRIVILEGES ON klinik_025.* TO 'dev_025'@'localhost';
