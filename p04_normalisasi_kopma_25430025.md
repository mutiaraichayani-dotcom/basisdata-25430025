# Praktikum 4 — Normalisasi dan Skema Relasional (Kopma)

**Nama:** Mutiara Icha Yani  
**Npm:** 25430025  
**Kelas:** A  

## D.1 Dari UNF ke 1NF

**UNF** (grup berulang ditandai `{ }`):

```
NOTA_UNF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas,
          no_anggota, nama_anggota,
          { kode_barang, nama_barang, qty_detail_penjualan,
            harga_satuan_detail_penjualan, subtotal_detail_penjualan },
          jumlah_penjualan, diskon_penjualan, total_penjualan)
```

**1NF**: satu baris per barang per nota. Kunci primer komposit `(no_nota_penjualan, kode_barang)`.

```
NOTA_1NF (no_nota_penjualan, kode_barang, tgl_penjualan, kode_petugas,
          nama_petugas, no_anggota, nama_anggota, nama_barang,
          qty_detail_penjualan, harga_satuan_detail_penjualan,
          subtotal_detail_penjualan, jumlah_penjualan, diskon_penjualan,
          total_penjualan)
```

### Anomali pada spreadsheet lama (Gambar 4.1)

| Anomali | Contoh pada spreadsheet Kopma |
|---|---|
| Ubah | Anggota yang sama ditulis "Budi S." (nota PJ-0142) dan "Budi Santoso" (nota PJ-0150); pemasok ditulis "CV Sumber ATK" dan "CV. Sumber A.T.K". Fakta yang sama tersimpan di banyak baris dan bisa berbeda. |
| Sisip | Barang baru tidak dapat dicatat sebelum ada penjualannya, karena tidak ada baris tanpa nomor nota. |
| Hapus | Menghapus nota PJ-0143 (satu-satunya baris Roti Cokelat dari pemasok UD Segar) ikut menghapus informasi barang dan pemasok UD Segar. |

## D.2 Dependensi fungsional (dari aturan bisnis, bukan dari isi data)

| FD | Dependensi | Dasar |
|---|---|---|
| FD1 | `no_nota_penjualan → tgl_penjualan, kode_petugas, no_anggota` | AB-01 (nota unik, satu tanggal, satu petugas, paling banyak satu anggota) |
| FD2 | `kode_petugas → nama_petugas` | kode petugas mengidentifikasi satu petugas |
| FD3 | `no_anggota → nama_anggota` | AB-05 (nomor anggota mengidentifikasi satu anggota) |
| FD4 | `kode_barang → nama_barang` | kode barang mengidentifikasi satu barang |
| FD5 | `(no_nota_penjualan, kode_barang) → qty_detail_penjualan, harga_satuan_detail_penjualan` | AB-04 |
| FD6 | `qty_detail_penjualan, harga_satuan_detail_penjualan → subtotal_detail_penjualan` | turunan |

Catatan: `kode_barang → harga_satuan_detail_penjualan` **tidak** dicantumkan karena melanggar AB-04.

### Titik Analisis 1

FD5 menaruh harga pada kunci `(no_nota_penjualan, kode_barang)` karena AB-04 menyatakan harga pada nota dapat berbeda dari harga barang saat ini. Harga ditentukan oleh pasangan nota dan barang, bukan oleh barang saja. Jika harga dipindah ke tabel `barang`, setiap kenaikan harga akan mengubah harga pada semua nota lama. Laporan omzet tahun lalu akan terhitung ulang dengan harga baru sehingga nilainya salah (membengkak) dan tidak lagi cocok dengan uang yang benar-benar diterima.

## D.3 Menuju 2NF dan 3NF

**2NF.** FD1 dan FD4 bergantung hanya pada sebagian kunci komposit.
- `no_nota_penjualan` → dipisah menjadi `penjualan`
- `kode_barang` → dipisah menjadi `barang`
- Sisanya menjadi `detail_penjualan`

**3NF.** Pada `penjualan` ada rantai `no_nota_penjualan → kode_petugas → nama_petugas` dan `no_nota_penjualan → no_anggota → nama_anggota`. Maka `petugas` dan `anggota` dipisah menjadi relasi sendiri.

**Nilai turunan.** `subtotal_detail_penjualan`, `jumlah_penjualan`, dan `total_penjualan` tidak disimpan di tabel operasional, tetapi dihitung dari detail dan status anggota (diskon 5% bila anggota aktif, AB-02).

### Tabel tahapan UNF → 1NF → 2NF → 3NF

| Tahap | Relasi yang dihasilkan | Masalah yang dihilangkan |
|---|---|---|
| UNF | `NOTA_UNF` dengan grup berulang barang | – |
| 1NF | `NOTA_1NF (no_nota_penjualan, kode_barang, …)` | grup berulang / sel berisi daftar |
| 2NF | `PENJUALAN`, `DETAIL_PENJUALAN`, `BARANG` | ketergantungan pada sebagian kunci (FD1, FD4) |
| 3NF | `PENJUALAN`, `DETAIL_PENJUALAN`, `BARANG`, `PETUGAS`, `ANGGOTA` | ketergantungan transitif (FD2, FD3) |

### Hasil 3NF

```
PENJUALAN        (no_nota_penjualan, tgl_penjualan, kode_petugas*, no_anggota*, bayar_penjualan)
DETAIL_PENJUALAN (no_nota_penjualan*, kode_barang*, qty_detail_penjualan, harga_satuan_detail_penjualan)
BARANG           (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang)
PETUGAS          (kode_petugas, nama_petugas, peran_petugas)
ANGGOTA          (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota)
-- kunci primer = atribut pertama (dan komposit pada DETAIL_PENJUALAN), * = kunci tamu
```

### Titik Analisis 2

Pada tabel operasional, nota dan harga masih dapat berubah, jadi total yang disimpan bisa tidak sinkron dengan detailnya; menghitungnya setiap kali dibutuhkan menjamin selalu konsisten. Tabel arsip penjualan di Buku 2 adalah potret historis: ia merekam keadaan pada saat tertentu dan tidak boleh berubah lagi. Total pada arsip tidak bisa menjadi tidak konsisten karena sumbernya tidak ikut berubah, dan menyimpannya mempercepat laporan. Jadi kedua keputusan itu sama-sama konsisten dengan prinsipnya: simpan nilai turunan hanya bila nilainya beku.

## D.4 Pencocokan dengan skema kanonik dan pemeriksaan BCNF

Perbedaan utama dengan hasil 3NF di atas: kanonik memakai kunci pengganti `id_*` sebagai kunci primer, sedangkan kode alami (`kode_petugas`, `no_anggota`, `nim_anggota`, `kode_barang`, `no_nota_penjualan`) menjadi kunci unik. Kanonik juga menambah `pemasok`, `pembelian`, dan `detail_pembelian`.

| Tabel | Kunci primer | Kunci unik | Kunci tamu |
|---|---|---|---|
| petugas | id_petugas | kode_petugas | – |
| anggota | id_anggota | no_anggota, nim_anggota | – |
| barang | id_barang | kode_barang | – |
| pemasok | id_pemasok | – | – |
| penjualan | id_penjualan | no_nota_penjualan | id_petugas, id_anggota (boleh NULL) |
| detail_penjualan | (id_penjualan, id_barang) | – | id_penjualan, id_barang |
| pembelian | id_pembelian | – | id_pemasok |
| detail_pembelian | (id_pembelian, id_barang) | – | id_pembelian, id_barang |

### Pemeriksaan BCNF (setiap penentu harus kunci kandidat)

| Tabel | Penentu | Kunci kandidat? | Hasil |
|---|---|---|---|
| petugas | `id_petugas`, `kode_petugas` | ya, keduanya | BCNF |
| anggota | `id_anggota`, `no_anggota`, `nim_anggota` | ya, ketiganya (AB-05) | BCNF |
| barang | `id_barang`, `kode_barang` | ya, keduanya | BCNF |
| pemasok | `id_pemasok` | ya | BCNF |
| penjualan | `id_penjualan`, `no_nota_penjualan` | ya, keduanya (AB-01) | BCNF |
| detail_penjualan | `(id_penjualan, id_barang)` | ya | BCNF |
| pembelian | `id_pembelian` (`no_faktur_pembelian` bukan penentu: tidak unik) | ya | BCNF |
| detail_pembelian | `(id_pembelian, id_barang)` | ya | BCNF |

Semua tabel memenuhi BCNF. Kunci pengganti tidak menggantikan pemeriksaan ini: dependensi pada kunci alami (misalnya `nim_anggota → nama_anggota`) tetap diperiksa, dan terpenuhi karena `nim_anggota` berstatus UNIQUE.

### Titik Analisis 3

Informasi "barang ini dipasok oleh siapa" kini tersimpan lewat `detail_pembelian` (yang menunjuk `id_barang`) dan `pembelian` (yang menunjuk `id_pemasok`), yaitu dari riwayat pembelian. Keuntungannya: (1) satu barang dapat dipasok oleh beberapa pemasok tanpa mengubah struktur; (2) nama pemasok tersimpan sekali di `pemasok`, sehingga ejaan yang berubah-ubah (anomali ubah) tidak terjadi; (3) pemasok baru dapat dicatat sebelum ada barangnya (tidak ada anomali sisip); (4) riwayat harga beli per pembelian tetap tercatat.

## E. Latihan dan Modifikasi

### E.1 Beberapa nomor telepon untuk setiap pemasok

Tabel `pemasok` hanya punya satu kolom `telepon_pemasok`. Menyimpan beberapa nomor dalam satu sel, atau menambah kolom `telepon1, telepon2, …`, melanggar 1NF (nilai tidak atomik / grup berulang). Solusinya relasi baru, dan kolom `telepon_pemasok` dihapus dari `pemasok`:

```
PEMASOK         (id_pemasok, nama_pemasok, alamat_pemasok)
TELEPON_PEMASOK (id_pemasok*, nomor_telepon_pemasok, keterangan_telepon_pemasok)
-- kunci primer komposit (id_pemasok, nomor_telepon_pemasok); id_pemasok = kunci tamu ke PEMASOK
```

`keterangan_telepon_pemasok` (mis. kantor, WhatsApp) bergantung pada seluruh kunci komposit, sehingga relasi ini 2NF, 3NF, dan BCNF.

### E.2 Pelanggaran 3NF bila `nama_anggota` disimpan di `penjualan`

Misalkan `penjualan` berisi kolom `nama_anggota`. Ada rantai `id_penjualan → no_anggota → nama_anggota`, yaitu ketergantungan transitif (melanggar 3NF).

Contoh data:

| no_nota_penjualan | no_anggota | nama_anggota |
|---|---|---|
| PJ-2610-0001 | A-0007 | Siti Aisyah |
| PJ-2610-0002 | A-0007 | Siti Aisyah |
| PJ-2610-0003 | A-0007 | Siti Aisyah |

Kueri ubah yang memperlihatkan anomali (nama ejaan diperbarui, tetapi hanya satu nota yang tersentuh):

```sql
UPDATE penjualan
SET nama_anggota = 'Siti Aisyah Putri'
WHERE no_nota_penjualan = 'PJ-2610-0003';
```

Akibatnya anggota `A-0007` kini punya dua nama berbeda di nota yang berbeda. Agar konsisten, kueri harus mengubah semua nota anggota itu (`WHERE no_anggota = 'A-0007'`) dan tidak ada yang menjamin hal itu dilakukan. Pada rancangan 3NF nama hanya ada di `anggota`, jadi cukup satu baris yang diubah.
