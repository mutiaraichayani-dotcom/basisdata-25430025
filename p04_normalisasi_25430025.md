\# Normalisasi Basis Data — Proyek Klinik Mutiara



Nama: Mutiara Icha Yani

NPM: 25430025

Kelas: A

Proyek: Klinik Mutiara





\## 1. Dokumen Sumber



Dokumen sumber: \*\*Resep Obat\*\* (dokumen sumber proyek Klinik Mutiara, Pertemuan 2). Satu resep dibuat dari satu pemeriksaan pasien dan memuat satu atau lebih obat.



\## 2. Bentuk Tidak Normal (UNF)



```text

RESEP\_UNF(

&#x20; id\_resep, tanggal\_resep,

&#x20; id\_pemeriksaan, tanggal\_pemeriksaan, diagnosis,

&#x20; id\_pasien, nama\_pasien,

&#x20; id\_dokter, nama\_dokter,

&#x20; {id\_obat, nama\_obat, satuan, jumlah\_obat, aturan\_penggunaan}

)

```



Kelompok berulang `{ ... }` adalah daftar obat dalam satu resep.



\## 3. Bentuk Normal Pertama (1NF)



Setiap obat ditempatkan pada baris sendiri; kunci primer `(id\_resep, id\_obat)`. Keputusan: satu jenis obat dicatat sekali per resep, dan banyaknya dicatat pada `jumlah\_obat`.



```text

RESEP\_1NF(

&#x20; id\_resep, id\_obat,

&#x20; tanggal\_resep, id\_pemeriksaan, tanggal\_pemeriksaan, diagnosis,

&#x20; id\_pasien, nama\_pasien, id\_dokter, nama\_dokter,

&#x20; nama\_obat, satuan, jumlah\_obat, aturan\_penggunaan

)

```



\## 4. Dependensi Fungsional



Diturunkan dari arti data dan aturan bisnis, bukan dari isi contoh data.



| FD | Dependensi | Dasar aturan bisnis |

|---|---|---|

| FD1 | `id\_resep → tanggal\_resep, id\_pemeriksaan` | Satu resep berasal dari satu pemeriksaan (AB-05) |

| FD2 | `id\_pemeriksaan → tanggal\_pemeriksaan, diagnosis, id\_pasien, id\_dokter` | Satu pemeriksaan = satu pasien, satu dokter, satu tanggal (AB-03, AB-04) |

| FD3 | `id\_dokter → nama\_dokter` | Satu dokter memiliki satu nama (AB-03) |

| FD4 | `id\_pasien → no\_pasien, nama\_pasien` | Nomor pasien unik dan mengidentifikasi satu pasien (AB-01) |

| FD5 | `id\_obat → nama\_obat, satuan, stok, batas\_minimum\_stok` | Satu jenis obat; stok dan batas minimum dicatat per obat (AB-07, AB-08) |

| FD6 | `(id\_resep, id\_obat) → jumlah\_obat, aturan\_penggunaan` | Jumlah dan aturan pakai dicatat per obat per resep (AB-06) |



Dependensi dari bagian ERD yang tidak berasal dari lembar resep (dicantumkan agar seluruh ERD terperiksa):

\- FD7: `id\_pasien → id\_petugas` (pasien didaftarkan oleh satu petugas; KI-06)

\- FD8: `id\_petugas → nama\_petugas, jabatan`

\- FD9: `no\_pasien → id\_pasien` (nomor pasien unik, AB-01), sehingga `no\_pasien` juga kunci kandidat



`stok` dan `batas\_minimum\_stok` tidak tampil di lembar resep, tetapi dimiliki entitas `OBAT` pada ERD.



\## 5. Bentuk Normal Kedua (2NF)



Atribut yang bergantung pada sebagian kunci `(id\_resep, id\_obat)` dipisahkan:

\- FD1 (hanya `id\_resep`) beserta atribut lanjutannya → `RESEP`

\- FD5 (hanya `id\_obat`) → `OBAT`

\- sisanya → `DETAIL\_RESEP`



```text

RESEP(id\_resep \[PK], tanggal\_resep, id\_pemeriksaan, tanggal\_pemeriksaan, diagnosis,

&#x20;     id\_pasien, nama\_pasien, id\_dokter, nama\_dokter)



OBAT(id\_obat \[PK], nama\_obat, satuan, stok, batas\_minimum\_stok)



DETAIL\_RESEP(id\_resep \[PK, FK], id\_obat \[PK, FK], jumlah\_obat, aturan\_penggunaan)

```



`RESEP` masih memuat rantai ketergantungan; ini dibereskan pada 3NF.



\## 6. Bentuk Normal Ketiga (3NF)



Pada `RESEP` terdapat tiga rantai transitif:

\- `id\_resep → id\_pemeriksaan → tanggal\_pemeriksaan, diagnosis, id\_pasien, id\_dokter` (FD1 + FD2)

\- `id\_pemeriksaan → id\_dokter → nama\_dokter` (FD2 + FD3)

\- `id\_pemeriksaan → id\_pasien → nama\_pasien` (FD2 + FD4)



Maka `PEMERIKSAAN`, `DOKTER`, dan `PASIEN` dipisah, dan `RESEP` hanya menyimpan kunci tamu ke pemeriksaan.



```text

PASIEN(id\_pasien \[PK], no\_pasien \[UNIQUE], nomor\_identitas, nama\_pasien, tanggal\_lahir,

&#x20;      jenis\_kelamin, alamat, no\_telepon, id\_petugas \[FK])

PETUGAS(id\_petugas \[PK], nama\_petugas, jabatan)

DOKTER(id\_dokter \[PK], nama\_dokter)

PEMERIKSAAN(id\_pemeriksaan \[PK], id\_pasien \[FK], id\_dokter \[FK], tanggal\_pemeriksaan, diagnosis)

RESEP(id\_resep \[PK], id\_pemeriksaan \[FK], tanggal\_resep)

OBAT(id\_obat \[PK], nama\_obat, satuan, stok, batas\_minimum\_stok)

DETAIL\_RESEP(id\_resep \[PK, FK], id\_obat \[PK, FK], jumlah\_obat, aturan\_penggunaan)

```



`PETUGAS` dan kolom `id\_petugas` pada `PASIEN` tidak diturunkan dari lembar resep; keduanya mengikuti ERD (relasi "mendaftarkan").



\### Tabel tahapan UNF → 1NF → 2NF → 3NF



| Tahap | Relasi | Masalah yang dihilangkan |

|---|---|---|

| UNF | `RESEP\_UNF` | – |

| 1NF | `RESEP\_1NF` | kelompok berulang obat |

| 2NF | `RESEP`, `OBAT`, `DETAIL\_RESEP` | ketergantungan pada sebagian kunci (FD1, FD5) |

| 3NF | `RESEP`, `PEMERIKSAAN`, `PASIEN`, `DOKTER`, `OBAT`, `DETAIL\_RESEP` | ketergantungan transitif (FD2, FD3, FD4) |



\### Kunci pada skema akhir



ERD sudah memakai kunci pengganti `id\_<tabel>`. Nomor pasien menjadi kunci unik. Kunci pengganti tidak menghapus dependensi fungsional, sehingga BCNF di bawah diperiksa terhadap FD, termasuk `no\_pasien`.



| Tabel | Kunci primer | Kunci unik | Kunci tamu |

|---|---|---|---|

| pasien | id\_pasien | no\_pasien | id\_petugas |

| petugas | id\_petugas | – | – |

| dokter | id\_dokter | – | – |

| pemeriksaan | id\_pemeriksaan | – | id\_pasien, id\_dokter |

| resep | id\_resep | – | id\_pemeriksaan |

| obat | id\_obat | – | – |

| detail\_resep | (id\_resep, id\_obat) | – | id\_resep, id\_obat |



\## 7. Pemeriksaan BCNF



| Relasi | Penentu | Kunci kandidat? | Hasil |

|---|---|---|---|

| PASIEN | `id\_pasien`, `no\_pasien` | ya, keduanya (AB-01) | BCNF |

| PETUGAS | `id\_petugas` | ya | BCNF |

| DOKTER | `id\_dokter` | ya | BCNF |

| PEMERIKSAAN | `id\_pemeriksaan` | ya | BCNF |

| RESEP | `id\_resep` | ya | BCNF |

| OBAT | `id\_obat` | ya | BCNF |

| DETAIL\_RESEP | `(id\_resep, id\_obat)` | ya | BCNF |



Semua relasi memenuhi BCNF: pada setiap relasi, seluruh penentu dari FD1–FD9 adalah kunci kandidat. Kesimpulan ini berlaku untuk dependensi yang tercantum di atas.



\## 8. Keputusan Nilai Turunan



| Nilai turunan | Keputusan | Alasan |

|---|---|---|

| Jumlah dan jenis obat dalam satu resep (KI-07) | Dihitung dari `DETAIL\_RESEP` | Berubah bila detail diperbarui; nilai tersimpan bisa tidak sesuai detail |

| Status obat mendekati batas minimum (KI-04) | Dihitung dengan membandingkan `stok` dan `batas\_minimum\_stok` | Status berubah setiap stok berubah |

| Jumlah pasien per hari atau bulan (KI-01) dan per dokter (KI-05) | Dihitung dari `PEMERIKSAAN` berdasarkan tanggal dan dokter | Hasil agregasi yang selalu dapat dihitung dari data pemeriksaan |



`jumlah\_obat` dan `aturan\_penggunaan` adalah fakta transaksi, bukan nilai turunan, sehingga tetap disimpan di `DETAIL\_RESEP`.



\## 9. Perubahan ERD



Normalisasi memperlihatkan bahwa ERD Modul 3 sudah memisahkan obat, dokter, dan pemeriksaan dengan benar (nama dokter tidak disalin ke `RESEP`, `DETAIL\_RESEP` menjadi entitas asosiatif, dan tidak ada atribut turunan). Perubahan yang diperlukan:



1\. \*\*`PASIEN`: kunci primer.\*\* ERD memakai `no\_pasien` sebagai PK, sedangkan `PEMERIKSAAN` merujuk dengan FK `id\_pasien`; kunci tamu harus sama persis dengan kunci primer yang dirujuk. Perubahan: PK menjadi `id\_pasien`, dan `no\_pasien` menjadi kolom unik (AB-01).

2\. \*\*`PASIEN`: kunci tamu petugas.\*\* Relasi "petugas mendaftarkan pasien" (1 : 0..N) belum punya kolom penghubung. Perubahan: tambahkan `id\_petugas` (FK) pada `PASIEN`.

3\. \*\*`RESEP`: penulisan atribut.\*\* `tanggal resep` ditulis `tanggal\_resep`.

