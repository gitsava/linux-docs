# Pengantar
Sistem manajemen basis data relasional adalah komponen penting dari banyak situs web dan aplikasi. Sistem ini menyediakan cara yang terstruktur untuk menyimpan, mengelola, dan mengakses informasi.

PostgreSQL, atau Postgres, adalah sistem manajemen basis data relasional yang memberikan penerapan dari bahasa kueri SQL. Sistem ini sesuai dengan standar dan memiliki banyak fitur lanjutan seperti transaksi yang andal dan konkurensi tanpa kunci baca.

Panduan ini mendemonstrasikan cara menginstal Postgres pada server Ubuntu 20.04. Panduan ini juga menyediakan beberapa instruksi untuk administrasi basis data umum.

## Prasyarat
Untuk mengikuti tutorial ini, Anda akan membutuhkan satu server Ubuntu 20.04 yang telah dikonfigurasi dengan mengikuti Panduan Penyiapan Server Awal untuk Ubuntu 20.04 dari kami. Setelah menyelesaikan tutorial prasyarat ini, server Anda akan memiliki pengguna non-root dengan izin sudo dan firewall dasar.

Langkah 1 — Menginstal PostgreSQL
Repositori asali Ubuntu memuat paket Postgres, sehingga Anda dapat menginstal ini menggunakan sistem paket apt.

Jika Anda belum melakukan itu baru-baru ini, segarkan indeks paket lokal server Anda:
```
sudo apt update
``` 
Lalu, instal paket Postgres bersama dengan paket -contrib yang menambah beberapa utilitas dan fungsionalitas tambahan:
```
sudo apt install postgresql postgresql-contrib
``` 
Karena kini perangkat lunak sudah terinstal, kita dapat memeriksa cara kerjanya dan kemungkinan perbedaannya dengan sistem manajemen basis data relasional lain yang Anda mungkin gunakan.

Langkah 2 — Menggunakan Peran dan Basis Data PostgreSQL
Secara asali, Postgres menggunakan konsep yang disebut “role” untuk menangani autentikasi dan otorisasi. Dalam beberapa hal, ini mirip dengan akun bergaya Unix reguler, tetapi Postgres tidak membedakan antara pengguna dan grup, serta alih-alih lebih memilih istilah “peran” yang fleksibel.

Setelah instalasi, Postgres sudah siap untuk menggunakan autentikasi ident, yang berarti ini mengasosiasikan peran-peran Postgres dengan akun sistem Unix/Linux yang cocok. Jika peran ada di dalam Postgres, nama pengguna Unix/Linux dengan nama yang sama dapat masuk sebagai peran itu.

Prosedur instalasi menciptakan akun pengguna bernama postgres yang terasosiasi dengan peran Postgres asali. Untuk menggunakan Postgres, Anda dapat log masuk ke akun itu.

Ada beberapa cara untuk memanfaatkan akun ini guna mengakses Postgres.

Beralih ke Akun postgres
Beralihlah ke akun postgres pada server Anda dengan mengetik:
```
sudo -i -u postgres
``` 
Anda kini dapat segera mengakses prompt PostgreSQL dengan mengetik:
```
psql
``` 
Dari sana, Anda bebas berinteraksi dengan sistem manajemen basis data sesuai kebutuhan.

Keluarlah dari prompt PostgreSQL dengan mengetik:
```
\q
``` 
Ini akan membawa Anda kembali ke prompt perintah Linux postgres.

Mengakses Prompt Postgres Tanpa Beralih Akun
Anda juga dapat menjalankan perintah yang Anda inginkan secara langsung menggunakan akun postgres dengan sudo.

Misalnya, pada contoh terakhir, Anda diperintahkan untuk pergi ke prompt Postgres dengan pertama-tama beralih ke pengguna postgres, lalu menjalankan psql untuk membuka prompt Postgres. Anda dapat melakukan ini dalam satu langkah dengan menjalankan perintah tunggal psql sebagai pengguna postgres dengan sudo, seperti ini:
```
sudo -u postgres psql
``` 
Ini akan membawa Anda log masuk secara langsung ke Postgres tanpa shell bash perantara di antaranya.

Sekali lagi, Anda dapat keluar dari sesi Postgres interaktif dengan mengetik:
```
\q
``` 
Banyak kasus penggunaan membutuhkan lebih dari satu peran Postgres. Lanjutkan membaca mempelajari cara mengonfigurasi ini.

Langkah 3 — Menciptakan Peran Baru
Saat ini, Anda baru saja mengonfigurasi peran postgres di dalam basis data. Anda dapat membuat peran baru dari baris perintah dengan perintah createrole. Bendera --interactive akan meminta nama peran baru ini kepada Anda serta menanyakan apakah bendera itu harus memiliki izin superuser.

Jika Anda log masuk sebagai akun postgres, Anda dapat membuat pengguna baru dengan mengetik:
```
createuser --interactive
``` 
Jika Anda lebih memilih untuk menggunakan sudo untuk setiap perintah tanpa berpindah dari akun normal Anda, ketik:
```
sudo -u postgres createuser --interactive
``` 
Skrip akan memberi Anda beberapa pilihan dan, berdasarkan respons Anda, menjalankan perintah Postgres yang benar untuk menciptakan pengguna sesuai dengan spesifikasi Anda.
```
Output
Enter name of role to add: sammy
Shall the new role be a superuser? (y/n) y
Anda dapat memiliki kontrol lebih banyak dengan memberi beberapa bendera tambahan. Periksa opsi dengan membuka laman man:
```
```
man createuser
``` 
Instalasi Postgres Anda kini memiliki pengguna baru, tetapi Anda belum menambahkan basis data apa pun. Bagian selanjutnya menggambarkan proses ini.

Langkah 4 — Menciptakan Basis Data Baru
Asumsi lain yang dibuat oleh sistem autentikasi Postgres secara asali adalah bahwa pada setiap peran yang digunakan untuk log masuk akan memiliki basis data bernama sama yang dapat diakses oleh peran itu.

Ini berarti bahwa jika pengguna yang Anda ciptakan di bagian terakhir bernama sammy, maka peran itu akan mencoba terhubung ke basis data yang juga bernama “sammy” secara asali. Anda dapat menciptakan basis data yang sesuai dengan perintah createdb.

Jika Anda log masuk sebagai akun postgres, Anda dapat mengetik sesuatu seperti:
```
createdb sammy
``` 
Jika Anda lebih memilih untuk menggunakan sudo untuk setiap perintah tanpa berpindah dari akun normal, Anda dapat mengetik:
```
sudo -u postgres createdb sammy
``` 
Fleksibilitas ini menyediakan beberapa jalur untuk menciptakan basis data sesuai kebutuhan.

Langkah 5 — Membuka Prompt Postgres dengan Peran Baru
Untuk log masuk dengan autentikasi berbasis ident, Anda akan membutuhkan pengguna Linux dengan nama yang sama dengan peran dan basis data Postgres.

Jika tidak ada pengguna Linux yang cocok, Anda dapat menciptakannya dengan perintah adduser. Anda harus melakukan ini dari akun non-root dengan privilese sudo (yang berarti, tidak log masuk sebagai pengguna postgres):
```
sudo adduser sammy
``` 
Setelah akun baru ini tersedia, Anda dapat beralih dan terhubung ke basis data itu dengan mengetik:
```
sudo -i -u sammy
psql
``` 
Atau, Anda dapat melakukannya dalam baris ini:
```
sudo -u sammy psql
``` 
Perintah ini akan membuat Anda log masuk secara otomatis, dengan asumsi bahwa semua komponen telah dikonfigurasi dengan benar.

Jika Anda ingin pengguna terhubung ke basis data yang berbeda, Anda dapat melakukannya dengan menetapkan basis datanya seperti ini:
```
psql -d postgres
``` 
Setelah log masuk, Anda dapat memeriksa informasi koneksi saat ini dengan mengetik:
```
\conninfo
```
``` 
Output
You are connected to database "sammy" as user "sammy" via socket in "/var/run/postgresql" at port "5432".
```
Ini berguna jika Anda terhubung ke basis data non-asali atau menggunakan pengguna non-asali.

Langkah 6 — Membuat dan Menghapus Tabel
Karena kini Anda mengetahui cara terhubung ke sistem basis data PostgreSQL, Anda dapat mempelajari beberapa tugas manajemen Postgres dasar.

Sintaks dasar untuk membuat tabel adalah sebagai berikut:
```
CREATE TABLE table_name (
    column_name1 col_type (field_length) column_constraints,
    column_name2 col_type (field_length),
    column_name3 col_type (field_length)
);
```
Seperti yang Anda lihat, perintah ini memberi nama pada tabel, lalu mendefinisikan kolom serta jenis kolom dan panjang maksimum dari data bidang. Anda juga dapat menambahkan batasan tabel pada masing-masing kolom.

Anda dapat mempelajari lebih lanjut tentang cara membuat dan mengelola tabel di Postgres di sini.

Untuk demonstrasi, buat tabel berikut:
```
CREATE TABLE playground (
    equip_id serial PRIMARY KEY,
    type varchar (50) NOT NULL,
    color varchar (25) NOT NULL,
    location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')),
    install_date date
);
``` 
Perintah ini akan membuat tabel yang menginventarisasi peralatan taman bermain. Kolom pertama di dalam tabel akan menampung nomor ID peralatan dari tipe serial, yang merupakan bilangan bulat yang bertambah secara otomatis. Kolom ini juga memiliki batasan dari PRIMARY KEY yang berarti bahwa nilai di dalamnya harus unik dan bukan nol.

Dua baris selanjutnya membuat kolom untuk type (jenis) peralatan dan color (warna) secara berurutan, yang tidak boleh kosong. Baris setelah baris ini membuat kolom location (lokasi) serta batasan yang mengharuskan nilai itu menjadi salah satu dari delapan kemungkinan nilai. Baris terakhir membuat kolom date (tanggal) yang merekam tanggal saat Anda memasang peralatan itu.

Untuk dua kolom (equip_id dan install_date) adalah perintah tidak menentukan panjang bidang. Alasan untuk ini adalah bahwa beberapa tipe data tidak memerlukan panjang rangkaian karena panjang atau format sudah tersirat.

Anda dapat melihat tabel baru Anda dengan mengetik:
```
\d
```
``` 
Output
                  List of relations
 Schema |          Name           |   Type   | Owner
--------+-------------------------+----------+-------
 public | playground              | table    | sammy
 public | playground_equip_id_seq | sequence | sammy
(2 rows)
```
Tabel taman bermain Anda ada di sini, tetapi juga ada sesuatu yang bernama playground_equip_id_seq yang merupakan sequence (urutan) tipe. Ini adalah representasi dari tipe serial yang Anda berikan pada kolom equip_id. Ini melacak angka selanjutnya pada urutan dan dibuat secara otomatis untuk kolom tipe ini.

Jika Anda hanya ingin melihat tabel tanpa urutan, Anda dapat mengetik:
```
\dt
```
``` 
Output
          List of relations
 Schema |    Name    | Type  | Owner
--------+------------+-------+-------
 public | playground | table | sammy
(1 row)
```
Setelah tabel siap, mari kita gunakan untuk berlatih mengelola data.

Langkah 7 — Menambahkan, Membuat Kueri, dan Menghapus Data pada Tabel
Karena Anda sudah memiliki tabel, Anda dapat memasukkan beberapa data ke dalamnya. Sebagai contoh, tambahkan perosotan dan ayunan dengan memanggil tabel yang Anda ingin tambahkan, menamai kolom, lalu memberi data untuk masing-masing kolom, seperti ini:
```
INSERT INTO playground (type, color, location, install_date) VALUES ('slide', 'blue', 'south', '2017-04-28');
INSERT INTO playground (type, color, location, install_date) VALUES ('swing', 'yellow', 'northwest', '2018-08-16');
``` 
Anda harus berhati-hati saat memasukkan data untuk menghindari beberapa masalah umum. Misalnya, jangan membungkus nama kolom dengan tanda kutip, tetapi nilai kolom yang Anda masukkan memang membutuhkan tanda kutip.

Hal lain yang harus diingat adalah bahwa Anda tidak memasukkan nilai untuk kolom equip_id. Karena nilai ini secara otomatis dihasilkan setiap kali Anda menambah baris baru ke tabel.

Ambil informasi yang Anda tambahkan dengan mengetik:
```
SELECT * FROM playground;
```
``` 
Output
 equip_id | type  | color  | location  | install_date
----------+-------+--------+-----------+--------------
        1 | slide | blue   | south     | 2017-04-28
        2 | swing | yellow | northwest | 2018-08-16
(2 rows)
```
Di sini, Anda dapat melihat bahwa equip_id telah berhasil diisi dan semua data yang lain telah terorganisir dengan benar.

Jika perosotan di taman bermain rusak dan Anda harus menghapusnya, Anda juga dapat menghapus baris dari tabel dengan mengetik:
```
DELETE FROM playground WHERE type = 'slide';
``` 
Buat kueri tabel lagi:
```
SELECT * FROM playground;
```
``` 
Output
 equip_id | type  | color  | location  | install_date
----------+-------+--------+-----------+--------------
        2 | swing | yellow | northwest | 2018-08-16
(1 row)
```
Perhatikan bahwa baris slide (perosotan) tidak lagi menjadi bagian dari tabel.

Langkah 8 — Menambahkan dan Menghapus Kolom dari Tabel
Setelah membuat tabel, Anda dapat mengubahnya dengan menambah atau menghapus kolom. Tambahkan kolom untuk menunjukkan kunjungan pemeliharaan terakhir pada setiap peralatan dengan mengetik:
```
ALTER TABLE playground ADD last_maint date;
``` 
Jika Anda melihat informasi tabel Anda lagi, Anda akan melihat kolom baru telah ditambahkan, tetapi tidak ada data yang dimasukkan:
```
SELECT * FROM playground;
```
``` 
Output
 equip_id | type  | color  | location  | install_date | last_maint
----------+-------+--------+-----------+--------------+------------
        2 | swing | yellow | northwest | 2018-08-16   |
(1 row)
```
Jika Anda menemukan bahwa kru pekerja menggunakan alat berbeda untuk melacak riwayat pemeliharaan, Anda dapat menghapusnya dari kolom dengan mengetik:
```
ALTER TABLE playground DROP last_maint;
``` 
Ini menghapus kolom last_maint dan nilai apa pun yang ditemukan di dalamnya, tetapi tidak mengubah semua data lainnya.

Langkah 9 — Memperbarui Data pada Tabel
Sejauh ini, Anda telah mempelajari cara menambahkan catatan ke tabel dan cara menghapusnya, tetapi tutorial ini belum membahas cara untuk mengubah entri yang ada.

Anda dapat memperbarui nilai-nilai dari entri yang sudah ada dengan meminta catatan yang Anda inginkan dan mengatur kolom pada nilai yang Anda ingin gunakan. Anda dapat meminta catatan swing (ini akan sesuai dengan setiap ayunan di tabel Anda) dan mengubah warnanya menjadi red (merah). Ini akan berguna jika Anda mengecat ayunan:
```
UPDATE playground SET color = 'red' WHERE type = 'swing';
``` 
Anda dapat memverifikasi bahwa operasi berhasil dengan meminta data lagi:
```
SELECT * FROM playground;
```
``` 
Output
 equip_id | type  | color | location  | install_date
----------+-------+-------+-----------+--------------
        2 | swing | red   | northwest | 2018-08-16
(1 row)
```
Seperti yang Anda lihat, perosotan kini sudah terdaftar sebagai berwarna merah.

Kesimpulan
Anda sekarang sudah siap dengan PostgreSQL di server Ubuntu 20.04. Jika Anda ingin mempelajari lebih lanjut tentang Postgres dan cara menggunakannya, kami menyarankan Anda untuk membaca panduan berikut:

Perbandingan sistem manajemen basis data relasional
Berlatih menjalankan kueri dengan SQL

# Add Repository pg_admin 
```
$ curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
$ sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
```
sudo apt install pgadmin4
