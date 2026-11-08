-- =====================================================
-- MODUL 6: DATA SAMPEL KLINIK MUTIARA
-- Nama : Mutiara Icha Yani
-- NPM  : 25430025
-- Kelas: A
-- Basis data: klinik_025
--
-- Jalankan setelah tabel dibuat dengan DDL Modul 5.
-- Skrip ini ditujukan untuk database kosong.
-- Jumlah data utama pemeriksaan: 50 baris pada 3 tanggal.
-- =====================================================

USE klinik_025;
START TRANSACTION;

-- 1. DATA PASIEN (5 baris)
INSERT INTO pasien
(no_pasien, no_identitas, nama_pasien, tanggal_lahir, alamat, no_telepon)
VALUES
('PS-001', '1871051201010001', 'Ayu Lestari', '2001-05-12', 'Jl. Melati No. 10', '081234560001'),
('PS-002', '1871052302020002', 'Budi Santoso', '2002-02-23', 'Jl. Kenanga No. 15', '081234560002'),
('PS-003', '1871051403030003', 'Citra Amelia', '2003-03-14', 'Jl. Mawar No. 8', '081234560003'),
('PS-004', '1871052504040004', 'Dedi Kurniawan', '2004-04-25', 'Jl. Anggrek No. 21', '081234560004'),
('PS-005', '1871051605050005', 'Eka Wulandari', '2005-05-16', 'Jl. Dahlia No. 7', '081234560005');

-- 2. DATA DOKTER (5 baris)
INSERT INTO dokter (kode_dokter, nama_dokter)
VALUES
('DR-001', 'dr. Andi Pratama'),
('DR-002', 'dr. Siti Rahmawati'),
('DR-003', 'dr. Bima Saputra'),
('DR-004', 'dr. Nanda Putri'),
('DR-005', 'dr. Rudi Hartono');

-- 3. DATA PETUGAS (5 baris)
INSERT INTO petugas (kode_petugas, nama_petugas, jabatan)
VALUES
('PT-001', 'Rina Oktaviani', 'Pendaftaran'),
('PT-002', 'Agus Setiawan', 'Pendaftaran'),
('PT-003', 'Dewi Anggraini', 'Farmasi'),
('PT-004', 'Fajar Nugroho', 'Farmasi'),
('PT-005', 'Lina Marlina', 'Administrasi');

-- 4. DATA OBAT (5 baris)
INSERT INTO obat
(kode_obat, nama_obat, stok, satuan, batas_minimum_stok)
VALUES
('OB-001', 'Paracetamol 500 mg', 200, 'Tablet', 20),
('OB-002', 'Amoxicillin 500 mg', 150, 'Kapsul', 15),
('OB-003', 'Antasida', 120, 'Tablet', 12),
('OB-004', 'Vitamin C 500 mg', 180, 'Tablet', 18),
('OB-005', 'Cetirizine 10 mg', 100, 'Tablet', 10);

-- 5. DATA PEMERIKSAAN (50 baris, tersebar pada 3 tanggal)
INSERT INTO pemeriksaan
(no_pemeriksaan, no_pasien, kode_dokter, tanggal_pemeriksaan, diagnosis)
VALUES
('PM-001','PS-001','DR-001','2026-10-01 08:00:00','Demam dan nyeri kepala'),
('PM-002','PS-002','DR-002','2026-10-01 08:15:00','Batuk dan pilek'),
('PM-003','PS-003','DR-003','2026-10-01 08:30:00','Gangguan pencernaan ringan'),
('PM-004','PS-004','DR-004','2026-10-01 08:45:00','Nyeri otot'),
('PM-005','PS-005','DR-005','2026-10-01 09:00:00','Alergi ringan'),
('PM-006','PS-001','DR-002','2026-10-01 09:15:00','Demam dan nyeri kepala'),
('PM-007','PS-002','DR-003','2026-10-01 09:30:00','Batuk dan pilek'),
('PM-008','PS-003','DR-004','2026-10-01 09:45:00','Gangguan pencernaan ringan'),
('PM-009','PS-004','DR-005','2026-10-01 10:00:00','Nyeri otot'),
('PM-010','PS-005','DR-001','2026-10-01 10:15:00','Alergi ringan'),
('PM-011','PS-001','DR-003','2026-10-01 10:30:00','Demam dan nyeri kepala'),
('PM-012','PS-002','DR-004','2026-10-01 10:45:00','Batuk dan pilek'),
('PM-013','PS-003','DR-005','2026-10-01 11:00:00','Gangguan pencernaan ringan'),
('PM-014','PS-004','DR-001','2026-10-01 11:15:00','Nyeri otot'),
('PM-015','PS-005','DR-002','2026-10-01 11:30:00','Alergi ringan'),
('PM-016','PS-001','DR-004','2026-10-02 08:00:00','Demam dan nyeri kepala'),
('PM-017','PS-002','DR-005','2026-10-02 08:15:00','Batuk dan pilek'),
('PM-018','PS-003','DR-001','2026-10-02 08:30:00','Gangguan pencernaan ringan'),
('PM-019','PS-004','DR-002','2026-10-02 08:45:00','Nyeri otot'),
('PM-020','PS-005','DR-003','2026-10-02 09:00:00','Alergi ringan'),
('PM-021','PS-001','DR-005','2026-10-02 09:15:00','Demam dan nyeri kepala'),
('PM-022','PS-002','DR-001','2026-10-02 09:30:00','Batuk dan pilek'),
('PM-023','PS-003','DR-002','2026-10-02 09:45:00','Gangguan pencernaan ringan'),
('PM-024','PS-004','DR-003','2026-10-02 10:00:00','Nyeri otot'),
('PM-025','PS-005','DR-004','2026-10-02 10:15:00','Alergi ringan'),
('PM-026','PS-001','DR-001','2026-10-02 10:30:00','Demam dan nyeri kepala'),
('PM-027','PS-002','DR-002','2026-10-02 10:45:00','Batuk dan pilek'),
('PM-028','PS-003','DR-003','2026-10-02 11:00:00','Gangguan pencernaan ringan'),
('PM-029','PS-004','DR-004','2026-10-02 11:15:00','Nyeri otot'),
('PM-030','PS-005','DR-005','2026-10-02 11:30:00','Alergi ringan'),
('PM-031','PS-001','DR-002','2026-10-03 08:00:00','Demam dan nyeri kepala'),
('PM-032','PS-002','DR-003','2026-10-03 08:15:00','Batuk dan pilek'),
('PM-033','PS-003','DR-004','2026-10-03 08:30:00','Gangguan pencernaan ringan'),
('PM-034','PS-004','DR-005','2026-10-03 08:45:00','Nyeri otot'),
('PM-035','PS-005','DR-001','2026-10-03 09:00:00','Alergi ringan'),
('PM-036','PS-001','DR-003','2026-10-03 09:15:00','Demam dan nyeri kepala'),
('PM-037','PS-002','DR-004','2026-10-03 09:30:00','Batuk dan pilek'),
('PM-038','PS-003','DR-005','2026-10-03 09:45:00','Gangguan pencernaan ringan'),
('PM-039','PS-004','DR-001','2026-10-03 10:00:00','Nyeri otot'),
('PM-040','PS-005','DR-002','2026-10-03 10:15:00','Alergi ringan'),
('PM-041','PS-001','DR-004','2026-10-03 10:30:00','Demam dan nyeri kepala'),
('PM-042','PS-002','DR-005','2026-10-03 10:45:00','Batuk dan pilek'),
('PM-043','PS-003','DR-001','2026-10-03 11:00:00','Gangguan pencernaan ringan'),
('PM-044','PS-004','DR-002','2026-10-03 11:15:00','Nyeri otot'),
('PM-045','PS-005','DR-003','2026-10-03 11:30:00','Alergi ringan'),
('PM-046','PS-001','DR-005','2026-10-03 11:45:00','Demam dan nyeri kepala'),
('PM-047','PS-002','DR-001','2026-10-03 12:00:00','Batuk dan pilek'),
('PM-048','PS-003','DR-002','2026-10-03 12:15:00','Gangguan pencernaan ringan'),
('PM-049','PS-004','DR-003','2026-10-03 12:30:00','Nyeri otot'),
('PM-050','PS-005','DR-004','2026-10-03 12:45:00','Alergi ringan');

-- 6. DATA RESEP (15 baris)
INSERT INTO resep (no_resep, no_pemeriksaan, tanggal_resep)
VALUES
('RP-001','PM-001','2026-10-01'),
('RP-002','PM-004','2026-10-01'),
('RP-003','PM-007','2026-10-01'),
('RP-004','PM-010','2026-10-01'),
('RP-005','PM-013','2026-10-01'),
('RP-006','PM-016','2026-10-02'),
('RP-007','PM-019','2026-10-02'),
('RP-008','PM-022','2026-10-02'),
('RP-009','PM-025','2026-10-02'),
('RP-010','PM-028','2026-10-02'),
('RP-011','PM-031','2026-10-03'),
('RP-012','PM-034','2026-10-03'),
('RP-013','PM-037','2026-10-03'),
('RP-014','PM-040','2026-10-03'),
('RP-015','PM-043','2026-10-03');

-- 7. DATA DETAIL RESEP (15 baris)
INSERT INTO detail_resep
(no_resep, kode_obat, jumlah_obat, aturan_penggunaan)
VALUES
('RP-001','OB-001',10,'Ikuti petunjuk dokter'),
('RP-002','OB-002',10,'Ikuti petunjuk dokter'),
('RP-003','OB-003',10,'Ikuti petunjuk dokter'),
('RP-004','OB-004',10,'Ikuti petunjuk dokter'),
('RP-005','OB-005',10,'Ikuti petunjuk dokter'),
('RP-006','OB-001',10,'Ikuti petunjuk dokter'),
('RP-007','OB-002',10,'Ikuti petunjuk dokter'),
('RP-008','OB-003',10,'Ikuti petunjuk dokter'),
('RP-009','OB-004',10,'Ikuti petunjuk dokter'),
('RP-010','OB-005',10,'Ikuti petunjuk dokter'),
('RP-011','OB-001',10,'Ikuti petunjuk dokter'),
('RP-012','OB-002',10,'Ikuti petunjuk dokter'),
('RP-013','OB-003',10,'Ikuti petunjuk dokter'),
('RP-014','OB-004',10,'Ikuti petunjuk dokter'),
('RP-015','OB-005',10,'Ikuti petunjuk dokter');

-- 8. VERIFIKASI JUMLAH DATA
SELECT 'pasien' AS tabel, COUNT(*) AS jumlah FROM pasien
UNION ALL SELECT 'dokter', COUNT(*) FROM dokter
UNION ALL SELECT 'petugas', COUNT(*) FROM petugas
UNION ALL SELECT 'obat', COUNT(*) FROM obat
UNION ALL SELECT 'pemeriksaan', COUNT(*) FROM pemeriksaan
UNION ALL SELECT 'resep', COUNT(*) FROM resep
UNION ALL SELECT 'detail_resep', COUNT(*) FROM detail_resep;

-- Verifikasi pemeriksaan tersebar pada tiga tanggal
SELECT DATE(tanggal_pemeriksaan) AS tanggal, COUNT(*) AS jumlah_pemeriksaan
FROM pemeriksaan
GROUP BY DATE(tanggal_pemeriksaan)
ORDER BY tanggal;

COMMIT;
