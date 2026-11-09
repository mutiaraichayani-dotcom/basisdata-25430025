-- ============================================================
-- MODUL 7: PROYEKSI DAN PENYARINGAN DATA KOPMA
-- Nama       : Mutiara Icha Yani
-- NPM        : 25430025
-- Kelas      : A
-- Basis data : kopma_025
-- File       : p07_kueri_kopma_25430025.sql
-- ============================================================

USE kopma_025;

-- ============================================================
-- D.1 PROYEKSI DAN PENYARINGAN
-- ============================================================

-- KI-03: menampilkan barang yang perlu dipesan ulang
SELECT
    kode_barang,
    nama_barang,
    stok_barang,
    stok_min_barang,
    stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_barang < stok_min_barang
ORDER BY kurang DESC;


-- KI-04: menampilkan barang kategori ATK atau minuman
SELECT
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang
FROM barang
WHERE kategori_barang IN ('ATK', 'minuman')
ORDER BY kategori_barang, nama_barang;


-- KI-05: menampilkan nota pada rentang tanggal September 2026
-- Sesuaikan tanggal jika rentang yang diminta pada praktikum berbeda.
SELECT
    no_nota_penjualan,
    tgl_penjualan,
    id_anggota,
    bayar_penjualan
FROM penjualan
WHERE tgl_penjualan BETWEEN '2026-09-01' AND '2026-09-30'
ORDER BY tgl_penjualan;


-- KI-06: menampilkan anggota yang belum memiliki nomor HP
SELECT
    no_anggota,
    nama_anggota,
    no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL
ORDER BY nama_anggota;


-- ============================================================
-- TITIK ANALISIS 1: PENGGUNAAN ALIAS PADA WHERE
-- ============================================================

-- Query uji yang sengaja salah (jangan aktifkan saat menjalankan
-- seluruh file), karena alias 'kurang' belum tersedia di WHERE:
-- SELECT
--     kode_barang,
--     nama_barang,
--     stok_barang,
--     stok_min_barang,
--     stok_min_barang - stok_barang AS kurang
-- FROM barang
-- WHERE kurang > 0;

-- Query perbaikan: tuliskan kembali perhitungannya pada WHERE
SELECT
    kode_barang,
    nama_barang,
    stok_barang,
    stok_min_barang,
    stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_min_barang - stok_barang > 0
ORDER BY kurang DESC;


-- ============================================================
-- D.2 POLA TEKS DAN NILAI KOSONG
-- ============================================================

-- KI-07: mencari anggota dengan nama mengandung huruf a
SELECT
    CONCAT(nama_anggota, ' (', no_anggota, ')') AS anggota,
    DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tanggal_daftar,
    IFNULL(no_hp_anggota, '-') AS hp,
    CASE
        WHEN status_anggota = 'aktif' THEN 'Diskon 5%'
        ELSE 'Tanpa diskon'
    END AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY tgl_daftar_anggota DESC
LIMIT 5;


-- Titik Analisis 2: cara yang benar untuk mencari nomor HP bernilai NULL
SELECT
    no_anggota,
    nama_anggota,
    no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL;


-- ============================================================
-- D.3 TANGGAL DAN PERHITUNGAN PER BARIS
-- ============================================================

-- KI-08: menghitung lama keanggotaan dalam hari
SELECT
    no_anggota,
    nama_anggota,
    tgl_daftar_anggota,
    DATEDIFF(CURDATE(), tgl_daftar_anggota) AS lama_hari,
    CASE
        WHEN DATEDIFF(CURDATE(), tgl_daftar_anggota) < 180 THEN 'Baru'
        ELSE 'Lama'
    END AS kategori_keanggotaan
FROM anggota
ORDER BY lama_hari DESC;


-- KI-09: menghitung subtotal setiap barang pada nota PJ-2609-0142
SELECT
    p.no_nota_penjualan,
    b.nama_barang,
    dp.qty_detail_penjualan,
    dp.harga_satuan_detail_penjualan,
    dp.qty_detail_penjualan * dp.harga_satuan_detail_penjualan AS subtotal
FROM penjualan p
JOIN detail_penjualan dp
    ON p.id_penjualan = dp.id_penjualan
JOIN barang b
    ON dp.id_barang = b.id_barang
WHERE p.no_nota_penjualan = 'PJ-2609-0142';


-- Titik Analisis 3: contoh fungsi agregat untuk menjumlahkan subtotal
-- Jalankan jika ingin melihat total seluruh subtotal nota tersebut.
SELECT
    p.no_nota_penjualan,
    SUM(dp.qty_detail_penjualan * dp.harga_satuan_detail_penjualan) AS total_nota
FROM penjualan p
JOIN detail_penjualan dp
    ON p.id_penjualan = dp.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0142'
GROUP BY p.no_nota_penjualan;


-- ============================================================
-- E. LATIHAN DAN MODIFIKASI
-- ============================================================

-- Latihan 1: nama barang huruf kapital dan harga format Rupiah
SELECT
    UPPER(nama_barang) AS nama_barang,
    CONCAT('Rp', FORMAT(harga_jual_barang, 0, 'id_ID')) AS harga
FROM barang;


-- Latihan 2A: query yang dapat dijalankan tetapi logikanya keliru
-- Tujuan: barang kategori ATK atau minuman yang harganya di atas 5000.
-- Kondisi ATK akan tetap tampil meskipun harganya <= 5000 karena
-- AND memiliki prioritas lebih tinggi daripada OR.
SELECT
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang
FROM barang
WHERE kategori_barang = 'ATK'
   OR kategori_barang = 'minuman'
   AND harga_jual_barang > 5000;


-- Latihan 2B: query yang sudah diperbaiki dengan tanda kurung
SELECT
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang
FROM barang
WHERE (kategori_barang = 'ATK'
       OR kategori_barang = 'minuman')
  AND harga_jual_barang > 5000;

-- ============================================================
-- AKHIR FILE MODUL 7
-- ============================================================
