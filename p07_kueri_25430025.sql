-- =====================================================
-- TUGAS MANDIRI MODUL 7
-- PROYEK DATABASE KLINIK MUTIARA
-- Nama       : Mutiara Icha Yani
-- NPM        : 25430025
-- Kelas      : A
-- Database   : klinik_025
--
-- Catatan:
-- Kueri disusun berdasarkan praktik yang sudah dilakukan.
-- KI-03 membutuhkan JOIN untuk menampilkan nama obat dalam resep.
-- KI-05 dapat dihitung dari tabel pemeriksaan, tetapi nama dokter
-- memerlukan JOIN dengan tabel dokter.
-- =====================================================

USE klinik_025;


-- =====================================================
-- KI-01
-- Pertanyaan: Berapa jumlah pasien yang berobat setiap hari?
-- Harapan: Menampilkan tanggal pemeriksaan dan jumlah pasien unik.
-- =====================================================

SELECT
    DATE(tanggal_pemeriksaan) AS tanggal,
    COUNT(DISTINCT no_pasien) AS jumlah_pasien
FROM pemeriksaan
GROUP BY DATE(tanggal_pemeriksaan)
ORDER BY tanggal;


-- =====================================================
-- KI-02
-- Pertanyaan: Bagaimana riwayat pemeriksaan pasien?
-- Harapan: Menampilkan riwayat pemeriksaan berdasarkan nomor pasien.
-- Catatan: Riwayat lengkap beserta identitas pasien dan dokter
-- membutuhkan JOIN. Kueri satu tabel ini menampilkan data pemeriksaan.
-- =====================================================

SELECT
    no_pemeriksaan,
    no_pasien,
    kode_dokter,
    tanggal_pemeriksaan,
    diagnosis
FROM pemeriksaan
ORDER BY tanggal_pemeriksaan DESC;


-- =====================================================
-- KI-03
-- Pertanyaan: Obat apa saja yang diberikan kepada pasien?
-- Harapan: Menampilkan informasi obat dalam resep.
-- Catatan: Membutuhkan JOIN tabel resep, detail_resep, dan obat
-- agar nama obat dan informasi resep dapat ditampilkan bersama.
-- Dikerjakan pada materi JOIN.
-- =====================================================


-- =====================================================
-- KI-04
-- Pertanyaan: Obat apa saja yang stoknya sudah mencapai batas minimum?
-- Harapan: Menampilkan nama obat, jumlah stok, dan batas minimum stok.
-- =====================================================

SELECT
    kode_obat,
    nama_obat,
    stok,
    satuan,
    batas_minimum_stok
FROM obat
WHERE stok <= batas_minimum_stok
ORDER BY stok ASC;


-- =====================================================
-- KI-05
-- Pertanyaan: Berapa jumlah pasien yang diperiksa setiap dokter?
-- Harapan: Menampilkan jumlah pasien berdasarkan kode dokter.
-- Catatan: Jumlah pemeriksaan/pasien per kode dokter dapat dihitung
-- dari tabel pemeriksaan. Nama dokter memerlukan JOIN tabel dokter.
-- =====================================================

SELECT
    kode_dokter,
    COUNT(DISTINCT no_pasien) AS jumlah_pasien
FROM pemeriksaan
GROUP BY kode_dokter
ORDER BY kode_dokter;


-- =====================================================
-- P07-11: LIKE
-- Pertanyaan: Pasien mana saja yang namanya mengandung huruf 'a'?
-- Harapan: Menampilkan pasien dengan nama yang mengandung huruf 'a'.
-- =====================================================

SELECT
    no_pasien,
    nama_pasien,
    tanggal_lahir,
    alamat
FROM pasien
WHERE nama_pasien LIKE '%a%'
ORDER BY nama_pasien ASC;


-- =====================================================
-- BETWEEN
-- Pertanyaan: Siapa saja pasien yang diperiksa pada tanggal
-- 1 sampai 3 Oktober 2026?
-- Harapan: Menampilkan data pemeriksaan dalam rentang tanggal tersebut.
-- =====================================================

SELECT
    no_pemeriksaan,
    no_pasien,
    tanggal_pemeriksaan,
    diagnosis
FROM pemeriksaan
WHERE DATE(tanggal_pemeriksaan)
BETWEEN '2026-10-01' AND '2026-10-03'
ORDER BY tanggal_pemeriksaan;


-- =====================================================
-- IN
-- Pertanyaan: Bagaimana data dari beberapa pasien tertentu?
-- Harapan: Menampilkan pasien dengan nomor PS-001, PS-002, dan PS-003.
-- =====================================================

SELECT
    no_pasien,
    nama_pasien,
    tanggal_lahir
FROM pasien
WHERE no_pasien IN ('PS-001', 'PS-002', 'PS-003');


-- =====================================================
-- IS NULL
-- Pertanyaan: Siapa saja pasien yang belum memiliki nomor telepon?
-- Harapan: Menampilkan pasien yang nomor teleponnya bernilai NULL.
-- =====================================================

SELECT
    no_pasien,
    nama_pasien,
    no_telepon
FROM pasien
WHERE no_telepon IS NULL;


-- =====================================================
-- CASE DAN CONCAT
-- Pertanyaan: Bagaimana kategori umur setiap pasien?
-- Harapan: Menampilkan umur pasien beserta kategori umurnya.
-- =====================================================

SELECT
    no_pasien,
    nama_pasien,
    CONCAT(YEAR(CURDATE()) - YEAR(tanggal_lahir), ' tahun') AS umur,
    CASE
        WHEN YEAR(CURDATE()) - YEAR(tanggal_lahir) < 18
            THEN 'Anak-anak'
        WHEN YEAR(CURDATE()) - YEAR(tanggal_lahir) < 60
            THEN 'Dewasa'
        ELSE 'Lansia'
    END AS kategori_umur
FROM pasien;
