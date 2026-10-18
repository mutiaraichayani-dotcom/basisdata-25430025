# Normalisasi Basis Data — Proyek Klinik Mutiara

## Nama: Mutiara Icha Yani
## NPM: 25430025
## Kelas: A
## Proyek: Klinik Mutiara

## 1. Dokumen Sumber

Dokumen sumber: **Resep Obat** (dokumen sumber proyek Klinik Mutiara, Pertemuan 2). Satu resep dibuat dari satu pemeriksaan pasien dan memuat satu atau lebih obat.

## 2. Bentuk Tidak Normal (UNF)

```text
RESEP_UNF(
  id_resep, tanggal_resep,
  id_pemeriksaan, tanggal_pemeriksaan, diagnosis,
  id_pasien, nama_pasien,
  id_dokter, nama_dokter,
  {id_obat, nama_obat, satuan, jumlah_obat, aturan_penggunaan}
)
```

Kelompok berulang `{ ... }` adalah daftar obat dalam satu resep.

## 3. Bentuk Normal Pertama (1NF)

Setiap obat ditempatkan pada baris sendiri; kunci primer `(id_resep, id_obat)`. Keputusan: satu jenis obat dicatat sekali per resep, dan banyaknya dicatat pada `jumlah_obat`.

```text
RESEP_1NF(
  id_resep, id_obat,
  tanggal_resep, id_pemeriksaan, tanggal_pemeriksaan, diagnosis,
  id_pasien, nama_pasien, id_dokter, nama_dokter,
  nama_obat, satuan, jumlah_obat, aturan_penggunaan
)
```

## 4. Dependensi Fungsional

Diturunkan dari arti data dan aturan bisnis, bukan dari isi contoh data.

| FD | Dependensi | Dasar aturan bisnis |
|---|---|---|
| FD1 | `id_resep → tanggal_resep, id_pemeriksaan` | Satu resep berasal dari satu pemeriksaan (AB-05) |
| FD2 | `id_pemeriksaan → tanggal_pemeriksaan, diagnosis, id_pasien, id_dokter` | Satu pemeriksaan = satu pasien, satu dokter, satu tanggal (AB-03, AB-04) |
| FD3 | `id_dokter → nama_dokter` | Satu dokter memiliki satu nama (AB-03) |
| FD4 | `id_pasien → no_pasien, nama_pasien` | Nomor pasien unik dan mengidentifikasi satu pasien (AB-01) |
| FD5 | `id_obat → nama_obat, satuan, stok, batas_minimum_stok` | Satu jenis obat; stok dan batas minimum dicatat per obat (AB-07, AB-08) |
| FD6 | `(id_resep, id_obat) → jumlah_obat, aturan_penggunaan` | Jumlah dan aturan pakai dicatat per obat per resep (AB-06) |

Dependensi dari bagian ERD yang tidak berasal dari lembar resep (dicantumkan agar seluruh ERD terperiksa):
- FD7: `id_pasien → id_petugas` (pasien didaftarkan oleh satu petugas; KI-06)
- FD8: `id_petugas → nama_petugas, jabatan`
- FD9: `no_pasien → id_pasien` (nomor pasien unik, AB-01), sehingga `no_pasien` juga kunci kandidat

`stok` dan `batas_minimum_stok` tidak tampil di lembar resep, tetapi dimiliki entitas `OBAT` pada ERD.

## 5. Bentuk Normal Kedua (2NF)

Atribut yang bergantung pada sebagian kunci `(id_resep, id_obat)` dipisahkan:
- FD1 (hanya `id_resep`) beserta atribut lanjutannya → `RESEP`
- FD5 (hanya `id_obat`) → `OBAT`
- sisanya → `DETAIL_RESEP`

```text
RESEP(id_resep [PK], tanggal_resep, id_pemeriksaan, tanggal_pemeriksaan, diagnosis,
      id_pasien, nama_pasien, id_dokter, nama_dokter)

OBAT(id_obat [PK], nama_obat, satuan, stok, batas_minimum_stok)

DETAIL_RESEP(id_resep [PK, FK], id_obat [PK, FK], jumlah_obat, aturan_penggunaan)
```

`RESEP` masih memuat rantai ketergantungan; ini dibereskan pada 3NF.

## 6. Bentuk Normal Ketiga (3NF)

Pada `RESEP` terdapat tiga rantai transitif:
- `id_resep → id_pemeriksaan → tanggal_pemeriksaan, diagnosis, id_pasien, id_dokter` (FD1 + FD2)
- `id_pemeriksaan → id_dokter → nama_dokter` (FD2 + FD3)
- `id_pemeriksaan → id_pasien → nama_pasien` (FD2 + FD4)

Maka `PEMERIKSAAN`, `DOKTER`, dan `PASIEN` dipisah, dan `RESEP` hanya menyimpan kunci tamu ke pemeriksaan.

```text
PASIEN(id_pasien [PK], no_pasien [UNIQUE], nomor_identitas, nama_pasien, tanggal_lahir,
       jenis_kelamin, alamat, no_telepon, id_petugas [FK])
PETUGAS(id_petugas [PK], nama_petugas, jabatan)
DOKTER(id_dokter [PK], nama_dokter)
PEMERIKSAAN(id_pemeriksaan [PK], id_pasien [FK], id_dokter [FK], tanggal_pemeriksaan, diagnosis)
RESEP(id_resep [PK], id_pemeriksaan [FK], tanggal_resep)
OBAT(id_obat [PK], nama_obat, satuan, stok, batas_minimum_stok)
DETAIL_RESEP(id_resep [PK, FK], id_obat [PK, FK], jumlah_obat, aturan_penggunaan)
```

`PETUGAS` dan kolom `id_petugas` pada `PASIEN` tidak diturunkan dari lembar resep; keduanya mengikuti ERD (relasi "mendaftarkan").

### Tabel tahapan UNF → 1NF → 2NF → 3NF

| Tahap | Relasi | Masalah yang dihilangkan |
|---|---|---|
| UNF | `RESEP_UNF` | – |
| 1NF | `RESEP_1NF` | kelompok berulang obat |
| 2NF | `RESEP`, `OBAT`, `DETAIL_RESEP` | ketergantungan pada sebagian kunci (FD1, FD5) |
| 3NF | `RESEP`, `PEMERIKSAAN`, `PASIEN`, `DOKTER`, `OBAT`, `DETAIL_RESEP` | ketergantungan transitif (FD2, FD3, FD4) |

### Kunci pada skema akhir

ERD sudah memakai kunci pengganti `id_<tabel>`. Nomor pasien menjadi kunci unik. Kunci pengganti tidak menghapus dependensi fungsional, sehingga BCNF di bawah diperiksa terhadap FD, termasuk `no_pasien`.

| Tabel | Kunci primer | Kunci unik | Kunci tamu |
|---|---|---|---|
| pasien | id_pasien | no_pasien | id_petugas |
| petugas | id_petugas | – | – |
| dokter | id_dokter | – | – |
| pemeriksaan | id_pemeriksaan | – | id_pasien, id_dokter |
| resep | id_resep | – | id_pemeriksaan |
| obat | id_obat | – | – |
| detail_resep | (id_resep, id_obat) | – | id_resep, id_obat |

## 7. Pemeriksaan BCNF

| Relasi | Penentu | Kunci kandidat? | Hasil |
|---|---|---|---|
| PASIEN | `id_pasien`, `no_pasien` | ya, keduanya (AB-01) | BCNF |
| PETUGAS | `id_petugas` | ya | BCNF |
| DOKTER | `id_dokter` | ya | BCNF |
| PEMERIKSAAN | `id_pemeriksaan` | ya | BCNF |
| RESEP | `id_resep` | ya | BCNF |
| OBAT | `id_obat` | ya | BCNF |
| DETAIL_RESEP | `(id_resep, id_obat)` | ya | BCNF |

Semua relasi memenuhi BCNF: pada setiap relasi, seluruh penentu dari FD1–FD9 adalah kunci kandidat. Kesimpulan ini berlaku untuk dependensi yang tercantum di atas.

## 8. Keputusan Nilai Turunan

| Nilai turunan | Keputusan | Alasan |
|---|---|---|
| Jumlah dan jenis obat dalam satu resep (KI-07) | Dihitung dari `DETAIL_RESEP` | Berubah bila detail diperbarui; nilai tersimpan bisa tidak sesuai detail |
| Status obat mendekati batas minimum (KI-04) | Dihitung dengan membandingkan `stok` dan `batas_minimum_stok` | Status berubah setiap stok berubah |
| Jumlah pasien per hari atau bulan (KI-01) dan per dokter (KI-05) | Dihitung dari `PEMERIKSAAN` berdasarkan tanggal dan dokter | Hasil agregasi yang selalu dapat dihitung dari data pemeriksaan |

`jumlah_obat` dan `aturan_penggunaan` adalah fakta transaksi, bukan nilai turunan, sehingga tetap disimpan di `DETAIL_RESEP`.

## 9. Perubahan ERD

Normalisasi memperlihatkan bahwa ERD Modul 3 sudah memisahkan obat, dokter, dan pemeriksaan dengan benar (nama dokter tidak disalin ke `RESEP`, `DETAIL_RESEP` menjadi entitas asosiatif, dan tidak ada atribut turunan). Perubahan yang diperlukan:

1. **`PASIEN`: kunci primer.** ERD memakai `no_pasien` sebagai PK, sedangkan `PEMERIKSAAN` merujuk dengan FK `id_pasien`; kunci tamu harus sama persis dengan kunci primer yang dirujuk. Perubahan: PK menjadi `id_pasien`, dan `no_pasien` menjadi kolom unik (AB-01).
2. **`PASIEN`: kunci tamu petugas.** Relasi "petugas mendaftarkan pasien" (1 : 0..N) belum punya kolom penghubung. Perubahan: tambahkan `id_petugas` (FK) pada `PASIEN`.
3. **`RESEP`: penulisan atribut.** `tanggal resep` ditulis `tanggal_resep`.
