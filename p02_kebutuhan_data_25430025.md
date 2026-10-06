# Analisis Kebutuhan Data Klinik Mutiara

## D.1 Membaca Studi Kasus

### Studi Kasus Klinik Mutiara

Klinik Mutiara merupakan klinik yang melayani pemeriksaan kesehatan pasien. Pasien yang datang terlebih dahulu melakukan pendaftaran dengan memberikan data identitas seperti nomor identitas, nama, tanggal lahir, alamat, dan nomor telepon.

Setelah melakukan pendaftaran, pasien dapat melakukan pemeriksaan dengan dokter. Dokter mencatat hasil pemeriksaan, keluhan pasien, diagnosis, serta tindakan yang diberikan. Jika diperlukan, dokter memberikan resep obat kepada pasien.

Petugas klinik mengelola data pasien, jadwal pemeriksaan, data dokter, dan data obat. Obat yang diberikan kepada pasien dicatat berdasarkan resep dari dokter. Stok obat diperiksa secara berkala agar klinik mengetahui obat yang tersedia dan obat yang mulai habis.

Pihak klinik membutuhkan laporan mengenai jumlah kunjungan pasien, riwayat pemeriksaan pasien, penggunaan obat, dan aktivitas dokter.

## D.2 Mengidentifikasi Aktor dan Proses Bisnis 
 
### Aktor 
 
1. Petugas pendaftaran 
2. Dokter 
3. Petugas farmasi 
4. Kepala klinik 
 
### Proses Bisnis 
 
| Kode | Proses Bisnis | Aktor | 
|---|---|---| 
| PB-01 | Mendaftarkan pasien | Petugas pendaftaran | 
| PB-02 | Mencatat pemeriksaan pasien | Dokter | 
| PB-03 | Mengelola resep dan obat | Petugas farmasi | 
| PB-04 | Mengelola stok obat | Petugas farmasi |
| PB-05 | Membuat laporan klinik | Kepala klinik |

## D.3 Menganalisis Dokumen Sumber

### 1. Formulir Pendaftaran Pasien

Dokumen ini digunakan saat pasien melakukan pendaftaran di Klinik Mutiara.

Data yang terdapat pada formulir:
- Nomor pasien
- Nomor identitas
- Nama pasien
- Tanggal lahir
- Jenis kelamin
- Alamat
- Nomor telepon

### 2. Lembar Pemeriksaan Pasien

Dokumen ini digunakan oleh dokter untuk mencatat pemeriksaan pasien.

Data yang terdapat pada lembar pemeriksaan:
- Nomor pemeriksaan
- Nomor pasien
- Tanggal pemeriksaan
- Dokter
- Diagnosis

### 3. Resep Obat

Dokumen ini digunakan oleh dokter untuk mencatat obat yang diberikan kepada pasien.

Data yang terdapat pada resep:
- Nomor resep
- Nomor pemeriksaan
- Tanggal resep
- Dokter
- Nama obat
- Jumlah obat
- Aturan penggunaan

### 4. Catatan Stok Obat

Dokumen ini digunakan oleh petugas farmasi untuk mencatat ketersediaan obat.

Data yang terdapat pada catatan stok:
- Kode obat
- Nama obat
- Stok obat
- Satuan
- Batas minimum stok

## D.4 Menyusun Entitas Kandidat dan Aturan Bisnis

### Entitas Kandidat

| Entitas Kandidat | Elemen Data Utama | Sumber |
|---|---|---|
| Pasien | nomor pasien, nomor identitas, nama, tanggal lahir, jenis kelamin, alamat, nomor telepon | Formulir pendaftaran pasien |
| Dokter | kode dokter, nama dokter | Lembar pemeriksaan pasien |
| Pemeriksaan | nomor pemeriksaan, nomor pasien, tanggal pemeriksaan, dokter, diagnosis | Lembar pemeriksaan pasien |
| Resep | nomor resep, nomor pemeriksaan, tanggal resep, dokter | Resep obat |
| Obat | kode obat, nama obat, stok, satuan, batas minimum stok | Catatan stok obat |
| Petugas | kode petugas, nama petugas, jabatan | Data klinik |

### Aturan Bisnis

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap pasien memiliki nomor pasien yang berbeda. |
| AB-02 | Pasien harus terdaftar sebelum melakukan pemeriksaan. |
| AB-03 | Setiap pemeriksaan dilakukan oleh satu dokter. |
| AB-04 | Setiap pemeriksaan memiliki tanggal pemeriksaan. |
| AB-05 | Resep hanya diberikan berdasarkan hasil pemeriksaan dokter. |
| AB-06 | Obat yang diberikan kepada pasien harus tercatat dalam resep. |
| AB-07 | Stok obat tidak boleh kurang dari nol. |
| AB-08 | Petugas farmasi melakukan pemeriksaan stok obat secara berkala. |

## D.5 Kebutuhan Informasi dan Matriks CRUD

### Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Data yang Diperlukan |
|---|---|---|
| KI-01 | Mengetahui banyaknya pasien yang datang untuk berobat dalam satu hari atau satu bulan | Pasien, pemeriksaan |
| KI-02 | Melihat catatan pemeriksaan yang pernah dilakukan oleh seorang pasien | Pasien, pemeriksaan, dokter |
| KI-03 | Mengetahui obat apa saja yang diberikan kepada pasien berdasarkan resep dokter | Pasien, resep, obat |
| KI-04 | Mengetahui obat yang jumlah persediaannya sudah mendekati batas minimum | Obat, stok, batas minimum stok |
| KI-05 | Mengetahui jumlah pasien yang diperiksa oleh masing-masing dokter | Dokter, pemeriksaan |

### Matriks CRUD

| Proses | Pasien | Dokter | Pemeriksaan | Resep | Obat | Petugas |
|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan pasien | C | - | - | - | - | R |
| PB-02 Mencatat pemeriksaan | R | R | C | - | - | - |
| PB-03 Mengelola resep dan obat | R | R | R | C | R | R |
| PB-04 Mengelola stok obat | - | - | - | - | R/U | R |
| PB-05 Membuat laporan klinik | R | R | R | R | R | R |

## D.6 Menyusun Kamus Data Awal

Kamus data digunakan untuk menjelaskan data yang akan disimpan dalam sistem Klinik Mutiara. Setiap data memiliki fungsi dan penanggung jawab agar data yang dicatat dapat dikelola dengan jelas.

### Kamus Data

| Entitas     | Elemen Data         | Keterangan                           | Penanggung Jawab    |
| ----------- | ------------------- | ------------------------------------ | ------------------- |
| Pasien      | Nomor pasien        | Nomor khusus untuk setiap pasien     | Petugas pendaftaran |
| Pasien      | Nomor identitas     | Nomor identitas pasien               | Petugas pendaftaran |
| Pasien      | Nama pasien         | Nama lengkap pasien                  | Petugas pendaftaran |
| Pasien      | Tanggal lahir       | Tanggal lahir pasien                 | Petugas pendaftaran |
| Pasien      | Jenis kelamin       | Jenis kelamin pasien                 | Petugas pendaftaran |
| Pasien      | Alamat              | Alamat tempat tinggal pasien         | Petugas pendaftaran |
| Pasien      | Nomor telepon       | Nomor yang dapat dihubungi           | Petugas pendaftaran |
| Dokter      | Kode dokter         | Kode untuk membedakan setiap dokter  | Kepala klinik       |
| Dokter      | Nama dokter         | Nama dokter yang bertugas            | Kepala klinik       |
| Pemeriksaan | Nomor pemeriksaan   | Nomor untuk setiap pemeriksaan       | Dokter              |
| Pemeriksaan | Nomor pasien        | Identitas pasien yang diperiksa      | Dokter              |
| Pemeriksaan | Tanggal pemeriksaan | Tanggal pasien diperiksa             | Dokter              |
| Pemeriksaan | Dokter              | Dokter yang melakukan pemeriksaan    | Dokter              |
| Pemeriksaan | Diagnosis           | Hasil pemeriksaan pasien             | Dokter              |
| Resep       | Nomor resep         | Nomor untuk setiap resep             | Dokter              |
| Resep       | Nomor pemeriksaan   | Pemeriksaan yang menjadi dasar resep | Dokter              |
| Resep       | Tanggal resep       | Tanggal resep dibuat                 | Dokter              |
| Resep       | Dokter              | Dokter yang membuat resep            | Dokter              |
| Obat        | Kode obat           | Kode untuk setiap jenis obat         | Petugas farmasi     |
| Obat        | Nama obat           | Nama obat yang tersedia              | Petugas farmasi     |
| Obat        | Stok obat           | Jumlah obat yang tersedia            | Petugas farmasi     |
| Obat        | Satuan              | Satuan penyimpanan obat              | Petugas farmasi     |
| Obat        | Batas minimum stok  | Batas minimal persediaan obat        | Petugas farmasi     |
| Petugas     | Kode petugas        | Kode untuk setiap petugas            | Kepala klinik       |
| Petugas     | Nama petugas        | Nama petugas yang bekerja di klinik  | Kepala klinik       |
| Petugas     | Jabatan             | Jabatan atau bagian petugas          | Kepala klinik       |

### Kebutuhan Non-Fungsional Data

1. **Volume data**
   Data pasien, pemeriksaan, resep, dan obat akan bertambah sesuai dengan aktivitas klinik.

2. **Retensi data**
   Data pasien dan riwayat pemeriksaan perlu disimpan agar dapat digunakan kembali ketika pasien melakukan kunjungan berikutnya.

3. **Privasi data**
   Data pasien dan hasil pemeriksaan termasuk data yang bersifat pribadi sehingga aksesnya harus dibatasi. Data pemeriksaan hanya boleh diakses oleh pihak yang memiliki kepentingan dalam pelayanan klinik.

4. **Keamanan data**
   Setiap pengguna sistem diberikan hak akses sesuai tugasnya. Petugas pendaftaran, dokter, petugas farmasi, dan kepala klinik tidak harus memiliki akses yang sama terhadap seluruh data.

## D.7 Menyusun Dokumen Kebutuhan Data

### 1. Latar Belakang dan Aktivitas Organisasi

Klinik Mutiara merupakan klinik yang melayani pasien mulai dari pendaftaran, pemeriksaan oleh dokter, pemberian resep, hingga pengelolaan obat. Data dari setiap kegiatan perlu dicatat agar informasi pasien dan kegiatan klinik dapat dikelola dengan baik.

### 2. Aktor dan Proses Bisnis

| Kode  | Proses Bisnis               | Aktor               |
| ----- | --------------------------- | ------------------- |
| PB-01 | Mendaftarkan pasien         | Petugas pendaftaran |
| PB-02 | Mencatat pemeriksaan pasien | Dokter              |
| PB-03 | Mengelola resep dan obat    | Petugas farmasi     |
| PB-04 | Mengelola stok obat         | Petugas farmasi     |
| PB-05 | Membuat laporan klinik      | Kepala klinik       |

### 3. Dokumen Sumber yang Dianalisis

Dokumen yang digunakan sebagai sumber data Klinik Mutiara yaitu:

* Formulir pendaftaran pasien
* Lembar pemeriksaan pasien
* Resep obat
* Catatan stok obat

### 4. Entitas Kandidat dan Elemen Data

Entitas yang digunakan dalam sistem Klinik Mutiara adalah:

1. **Pasien** — nomor pasien, nomor identitas, nama, tanggal lahir, jenis kelamin, alamat, dan nomor telepon.
2. **Dokter** — kode dokter dan nama dokter.
3. **Pemeriksaan** — nomor pemeriksaan, nomor pasien, tanggal pemeriksaan, dokter, dan diagnosis.
4. **Resep** — nomor resep, nomor pemeriksaan, tanggal resep, dan dokter.
5. **Obat** — kode obat, nama obat, stok, satuan, dan batas minimum stok.
6. **Petugas** — kode petugas, nama petugas, dan jabatan.

### 5. Aturan Bisnis

| Kode  | Aturan Bisnis                                                   |
| ----- | --------------------------------------------------------------- |
| AB-01 | Setiap pasien memiliki nomor pasien yang berbeda.               |
| AB-02 | Pasien harus terdaftar sebelum melakukan pemeriksaan.           |
| AB-03 | Setiap pemeriksaan dilakukan oleh satu dokter.                  |
| AB-04 | Setiap pemeriksaan memiliki tanggal pemeriksaan.                |
| AB-05 | Resep hanya diberikan berdasarkan hasil pemeriksaan dokter.     |
| AB-06 | Obat yang diberikan kepada pasien harus tercatat dalam resep.   |
| AB-07 | Stok obat tidak boleh kurang dari nol.                          |
| AB-08 | Petugas farmasi melakukan pemeriksaan stok obat secara berkala. |

### 6. Kebutuhan Informasi

| Kode  | Kebutuhan Informasi                                   | Data yang Diperlukan        |
| ----- | ----------------------------------------------------- | --------------------------- |
| KI-01 | Mengetahui banyaknya pasien yang datang untuk berobat | Pasien, pemeriksaan         |
| KI-02 | Melihat catatan pemeriksaan seorang pasien            | Pasien, pemeriksaan, dokter |
| KI-03 | Mengetahui obat yang diberikan kepada pasien          | Pasien, resep, obat         |
| KI-04 | Mengetahui obat yang mendekati batas minimum          | Obat, stok                  |
| KI-05 | Mengetahui jumlah pasien yang diperiksa setiap dokter | Dokter, pemeriksaan         |

### 7. Matriks CRUD

| Proses                         | Pasien | Dokter | Pemeriksaan | Resep | Obat | Petugas |
| ------------------------------ | ------ | ------ | ----------- | ----- | ---- | ------- |
| PB-01 Mendaftarkan pasien      | C      | -      | -           | -     | -    | R       |
| PB-02 Mencatat pemeriksaan     | R      | R      | C           | -     | -    | -       |
| PB-03 Mengelola resep dan obat | R      | R      | R           | C     | R    | R       |
| PB-04 Mengelola stok obat      | -      | -      | -           | -     | R/U  | R       |
| PB-05 Membuat laporan klinik   | R      | R      | R           | R     | R    | R       |

### 8. Kamus Data Awal

Kamus data berisi elemen data penting dari setiap entitas beserta pihak yang bertanggung jawab terhadap data tersebut. Data pasien dikelola oleh petugas pendaftaran, data pemeriksaan oleh dokter, data obat oleh petugas farmasi, sedangkan data dokter dan petugas dikelola oleh kepala klinik.

### 9. Kebutuhan Non-Fungsional Data

1. **Volume data**
   Data pasien, pemeriksaan, resep, dan obat akan bertambah sesuai dengan aktivitas klinik.

2. **Retensi data**
   Data pasien dan riwayat pemeriksaan perlu disimpan untuk kunjungan berikutnya.

3. **Privasi data**
   Data pasien hanya boleh diakses oleh petugas yang memiliki wewenang.

### 10. Isu Kualitas Data yang Diantisipasi

Beberapa masalah yang mungkin terjadi dalam pengelolaan data Klinik Mutiara yaitu data pasien yang tidak lengkap, kesalahan penulisan identitas, data obat yang tidak diperbarui, serta adanya data yang tercatat lebih dari satu kali.


