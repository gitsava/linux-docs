Memperbaiki nama_user is not in the sudoers file. This incident will be reported.

Dapat pertanyaan dari mas Rudi soal eksekusi perintah Linux yang gagal, dan terus terang mungkin saya sudah lelah jadi langsung main vonis saja. Haha… ternyata salah besar, minimal kurang tepat solusinya. Alur cerita errornya:

rudi@debian:~$ sudo apt-get update
[sudo] password for rudi: 
rudi is not in the sudoers file.  This incident will be reported.
rudi@debian:~$

Jadi tampak jelas hubungannya dengan sudo dan username rudi tidak memiliki hak akses untuk menjalankannya. Jadi cara memperbaikinya sendiri cukup jelas, mari kita tambahkan saja. Catatan saja, walaupun solusi ini bisa mengatasi masalahnya tapi harap pahami dulu apa yang sedang kita lakukan.

Tapi bukan berarti kita akan langsung mengedit konfigurasi sudo di /etc/sudoers walaupun sebenarnya bisa, karena sudah disediakan alatnya khusus yakni visudo:

    CentOS

    yum install visudo

    Debian/Ubuntu

    apt-get install visudo

Kemudian jalankan:
```
visudo
```
Akan muncul seperti ini:
```
root ALL=(ALL) ALL
```
Silahkan tambahkan tepat dibawahnya:
```
nama_user ALL=(ALL) ALL
```
Setelah itu simpan dan keluar, mestinya perintah yang gagal sebelumnya sudah bisa dieksekusi.

Ada lagi cara alternatifnya, jadi saat membuat user tambahkan ke dalam grup sudo:
```
adduser nama_user sudo
```