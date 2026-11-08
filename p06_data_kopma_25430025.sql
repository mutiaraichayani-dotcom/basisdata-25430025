-- =====================================================
-- MODUL 6: DATA SAMPEL KOPMA
-- Nama : Mutiara Icha Yani
-- NPM  : 25430025
-- Kelas: A
-- Basis data: kopma_025
--
-- CATATAN:
-- Skrip ini disiapkan untuk memuat data pada basis data
-- Kopma yang tabelnya sudah dibuat menggunakan DDL Modul 5.
-- Jangan jalankan ulang pada database yang sudah berisi data,
-- karena dapat menimbulkan data ganda atau stok berkurang lagi.
-- =====================================================

USE kopma_025;

-- 1. DATA PETUGAS
INSERT INTO petugas
    (kode_petugas, nama_petugas, peran_petugas)
VALUES
    ('K01', 'Dimas', 'kasir'),
    ('K02', 'Sari', 'kasir'),
    ('K03', 'Rina', 'kasir'),
    ('G01', 'Joko', 'gudang'),
    ('P01', 'Ketua Kopma', 'ketua');

-- 2. DATA BARANG
INSERT INTO barang
    (kode_barang, nama_barang, kategori_barang,
     harga_jual_barang, stok_barang, stok_min_barang)
VALUES
    ('ATK-001', 'Pulpen Gel 0.5', 'ATK', 4000, 120, 20),
    ('ATK-002', 'Buku Tulis 58', 'ATK', 6500, 80, 20),
    ('MNM-001', 'Air Mineral 600', 'minuman', 4000, 48, 24),
    ('MKN-001', 'Roti Cokelat', 'makanan', 5000, 6, 10);

-- 3. DATA ANGGOTA
INSERT INTO anggota
    (no_anggota, nim_anggota, nama_anggota, prodi_anggota,
     no_hp_anggota, status_anggota, tgl_daftar_anggota)
VALUES
    ('A001', '25430025', 'Mutiara Icha Yani', 'Ilmu Komputer',
     '081234567801', 'aktif', '2024-08-10'),
    ('A002', '25430026', 'Siti Rahma', 'Ilmu Komputer',
     '081234567802', 'aktif', '2024-09-15'),
    ('A003', '25430027', 'Andi Saputra', 'Manajemen',
     '081234567803', 'nonaktif', '2023-07-20');

-- 4. DATA PEMASOK
INSERT INTO pemasok
    (nama_pemasok, telepon_pemasok, alamat_pemasok)
VALUES
    ('PT Sumber ATK', '081234567811', 'Metro'),
    ('CV Berkah Jaya', '081234567812', 'Lampung Tengah');

-- 5. DATA PENJUALAN
-- ID petugas dan anggota dicari berdasarkan kode/NIM,
-- sehingga tidak bergantung pada nilai AUTO_INCREMENT.
INSERT INTO penjualan
    (no_nota_penjualan, tgl_penjualan, id_petugas,
     id_anggota, bayar_penjualan)
SELECT
    'PJ-2609-0142',
    '2026-09-24 10:15:00',
    (SELECT id_petugas FROM petugas WHERE kode_petugas = 'K03'),
    (SELECT id_anggota FROM anggota WHERE nim_anggota = '25430025'),
    30000;

-- 6. DETAIL PENJUALAN
INSERT INTO detail_penjualan
    (id_penjualan, id_barang, qty_detail_penjualan,
     harga_satuan_detail_penjualan)
SELECT
    p.id_penjualan, b.id_barang, 3, b.harga_jual_barang
FROM penjualan p
JOIN barang b ON b.kode_barang = 'ATK-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0142';

INSERT INTO detail_penjualan
    (id_penjualan, id_barang, qty_detail_penjualan,
     harga_satuan_detail_penjualan)
SELECT
    p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p
JOIN barang b ON b.kode_barang = 'ATK-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0142';

INSERT INTO detail_penjualan
    (id_penjualan, id_barang, qty_detail_penjualan,
     harga_satuan_detail_penjualan)
SELECT
    p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p
JOIN barang b ON b.kode_barang = 'MNM-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0142';

-- 7. PENGURANGAN STOK SESUAI DETAIL NOTA
UPDATE barang
SET stok_barang = stok_barang - 3
WHERE kode_barang = 'ATK-001';

UPDATE barang
SET stok_barang = stok_barang - 2
WHERE kode_barang = 'ATK-002';

UPDATE barang
SET stok_barang = stok_barang - 1
WHERE kode_barang = 'MNM-001';

-- 8. PEMERIKSAAN DATA
SELECT * FROM petugas;
SELECT * FROM barang;
SELECT * FROM anggota;
SELECT * FROM pemasok;
SELECT * FROM penjualan
WHERE no_nota_penjualan = 'PJ-2609-0142';
SELECT dp.*
FROM detail_penjualan dp
JOIN penjualan p ON p.id_penjualan = dp.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0142';
