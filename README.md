# Laporan-Praktikum-Sisop-1

## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari. Hint: Base64, Hexdump

### Jawab :
> We're living the future so
> the present is our past.

## Soal 2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun
2012.

b. Tentukan tiga product line yang memberikan penjualan(quantity)
terbanyak pada soal poin a.

c. Tentukan tiga product yang memberikan penjualan(quantity)
terbanyak berdasarkan tiga product line yang didapatkan pada soal
poin b.

### Jawab :
2. a. United States

`awk -F ',' -v max=0 '{if($7=='2012' && $10>max){want=$1; max=$10}}END{print want} ' WA_Sales_Products_2012-14.csv`

2. b.

```awk -F ',' '{if(($7=="2012") && ($1=="United States")) produk[$4]+=$10} END {for(x in produk)print x}' WA_Sales_Products_2012-14.csv | sort -r | head -3```

2. c.

```awk -F ',' '{if(($7=="2012") && ($1=="United States") && ($4=="Personal Accessories" || $4 == "Outdoor Protection" || $4 =="Mountaineering Equipment")) produk[$6]+=$10} END {for(x in produk)print x}' WA_Sales_Products_2012-14.csv | sort -r | head -3```

## Soal 3. 

Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.

c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.

d. Password yang dihasilkan tidak boleh sama.

### Jawab :
```
a=1

 while :
 do
  if [ -f /home/ariefp/password$a.txt ]
  then
   a=$((a+1))
   continue
  else
   cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1 > /home/ariefp/password$a.txt

   break
  fi
  done
```
Untuk membuat sebuah string secara random digunakan `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1 ` dimana /dev/urandom adalah direktori untuk membuat string secara random. `tr -dc 'a-zA-Z0-9' ` digunakan untuk membuat string random tersebut terdiri dari hurul alphabet biasa maupun secara uppercase dan juga terdiri dari angka-angka. `fold -w 12` adalah panjang string yang diinginkan, dalam hal ini panjang string adalah 12. `head -n 1` berfungsi untuk mengambil satu baris saja string random

While dijalankan untuk mengecek apakah nama file untuk menyimpan password tersebut sudah ada atau belum. Jika sudah ada maka akan bertambah satu sampai nama filenya belum ada. 

## Soal 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”,
serta buatlah pencarian stringnya tidak bersifat case sensitive,
sehingga huruf kapital atau tidak, tidak menjadi masalah.

b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13

c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

### Jawab :

```
# !/bin/bash

awk '{if ($0 ~ /cron/ || $0 ~ /CRON/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog >> /home/ariefp/modul1/syslog5.log

 2-30/6 * * * * /bin/bash /home/arief/nomor5.sh
```
Untuk mengecek apakah mengandung 'cron', maka digunakan `$0 ~ /cron/ || $0 ~ /CRON/` dimana cron secara penulisan ada 2 kemungkinan yakni cron dan CRON. Lalu kemudian tidak mengandung sudo, maka digunakan $0 `!~ /sudo/` dan untuk syarat yang terakhir yaitu jumlah fieldnya kurang dari 13 `NF < 13`. Kemudian hasilnya disimpan dalam /home/ariefp/modul1/syslog5.log


