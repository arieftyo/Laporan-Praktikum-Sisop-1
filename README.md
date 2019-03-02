# SoalShift_modul1_c14

## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari. Hint: Base64, Hexdump


### Jawab :
```#!/bin/bash

for i in *.jpg
do
        base64 -d $i | xxd -r > /home/chrstnamelia/Documents/nature/tutu/$1
done

crontab:

13 14 * 2 5 /bin/bash /home/chrstnamelia/Documents/nature/soal1.sh

![alt text](/home/ariefp/Laporan-Praktikum-Sisop1/images/1.png)

```

Menggunakan base64 dan Hexdump(xxd). Variabel I adalah nama file. Untuk setiap file di dalam folder /home/chrstnamelia/Documents/nature*.jpg akan dilakukan decode dengan base64 -d dan akan dikembalikan lagi agar dapat dibaca dengan menggunakan Hexdump(xxd -r). Hasilnya akan tersimpan di dalam file yang bernama tutu.

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

Untuk mengecek yang memimiliki quantity terbesar maka dibuat variabel max. Variabel max digunakan untuk membandingkan nilai quantity dari suatu baris. Jika nilai quantitynya lebih besar maka nilai max akan diperbarui. Sehingga didapatkan nanti negara yang memiliki quantity terbesar

2. b.

```awk -F ',' '{if(($7=="2012") && ($1=="United States")) produk[$4]+=$10} END {for(x in produk)print x}' WA_Sales_Products_2012-14.csv | sort -nr | head -3```

Hasil yang didapatkan dari soal a adalah United States. Oleh karena itu United States ditambahkan sebagai syarat. Produk_line berada pada kolom ke-4. Setelah itu diurutkan dan diambil 3 teratas

2. c.

```awk -F ',' '{if(($7=="2012") && ($1=="United States") && ($4=="Personal Accessories" || $4 == "Outdoor Protection" || $4 =="Mountaineering Equipment")) produk[$6]+=$10} END {for(x in produk)print x}' WA_Sales_Products_2012-14.csv | sort -nr | head -3```

Hasil dari soal b adalah Personal Accessories, Outdoor Protection, Mountaineering Equipment. Sama seperti soal sebelumnya, hanya saja product berada pada kolom ke-6.


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

#!/bin/bash

a=1
b=1

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

while :
do
 if [ $b -gt $a ]
 then
  break
 elif [ $b == $a ]
 then
  b=$((b+1))
 elif [[("$(echo "$(</home/ariefp/password$a.txt)" )" == "$(echo "$(</home/ariefp/password$b.txt)" )")]]
 then
  rm /home/ariefp/password$a.txt
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1 > /home/ariefp/password$a.txt
  break
 else
  b=$((b+1))
 fi
done


```
Untuk membuat sebuah string secara random digunakan `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1 ` dimana /dev/urandom adalah direktori untuk membuat string secara random. `tr -dc 'a-zA-Z0-9' ` digunakan untuk membuat string random tersebut terdiri dari hurul alphabet biasa maupun secara uppercase dan juga terdiri dari angka-angka. `fold -w 12` adalah panjang string yang diinginkan, dalam hal ini panjang string adalah 12. `head -n 1` berfungsi untuk mengambil satu baris saja string random

While dijalankan untuk mengecek apakah nama file untuk menyimpan password tersebut sudah ada atau belum. Jika sudah ada maka akan bertambah satu sampai nama filenya belum ada. 

## Soal 4

Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan
pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki
urutan ke 12+2 = 14.

b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
empat belas, dan seterusnya.

c. setelah huruf z akan kembali ke huruf a

d. Backup file syslog setiap jam.

e. dan buatkan juga bash script untuk dekripsinya.

### Jawab :

```
nano soal4enkripsi.sh
#!/bin/bash
date=`date +"%H:%M %d-%b-%Y"` #penamaan back up file yagn akan disimpan
jam=`date +%H`      #menentukan jam
cat /var/log/syslog | xxd -p -c1 | awk -v a=$jam '  #mengabil file dari syslog, diubah ke bentuk hexdum 
#kemudian dikonversikan dari hexa ke kode ASCII
function hex2dec(h,i,x,v){  #mendefinisikan fungsi untuk mengubah hexadecimal ke decimal
  h=tolower(h);sub(/^0x/,"",h)  
  for(i=1;i<=length(h);++i){  
    x=index("0123456789abcdef" , substr(h,i,l)) #
    if(!x)return "NaN"  
    v=(16*v)+x-1  
  }
  return v  
}
BEGIN { jam = strtonum(a) } #mengkonversikan string ke number
{
  $1 = hex2dec(0x$1)  #mengambil 1 karakter untuk diubah ke bentuk decimal agar dapat digunakan
  if ($1 >= 65 && $1 <= 90){  #code untuk menghitung bilangan decimal agar mendapatkan huruf besar pada ASCII
    $1 = $1 - 65
    $1 = ($1 + jam) % 26
    $1 = $1 + 65
  }
  if ($1 >= 97 && $1 <= 122){ #code untuk menghitung bilangan decimal agar mendapatkan huruf kecil pada ASCII
    $1 = $1 - 97
    $1 = ($1 + jam) % 26
    $1 = $1 + 97
  }
  printf("%c", $1)  #mencetak karakter
}
' > /home/chrstnamelia/Documents/"$date".log




nano soal4dekripsi.sh

#!/bin/bash
hrs=${1:0:2}
cat "$1$2" | xxd -p -c1 | awk -v a=$hrs '
function hex2dec(h      ,i,x,v){
  h=tolower(h);sub(/^0x/,"",h)
  for(i=1;i<=length(h);++i){
    x=index("0123456789abcdef",substr(h,i,1))
    if(!x)return "NaN"
    v=(16*v)+x-1
  }
  return v
}
BEGIN { hrs = strtonum(a) }
{
        $1 = hex2dec(0x$1)
        if ($1 >= 65 && $1 <= 90) {
                $1 = $1 - 65
                $1 = ($1 - hrs) % 26
                while ($1 < 0)
                        $1 = $1 + 26
                $1 = $1 + 65
        }
        if ($1 >= 97 && $1 <= 122) {
                $1 = $1 - 97
                $1 = ($1 - hrs) % 26
                while ($1 < 0)
                        $1 = $1 + 26
                $1 = $1 + 97
        }
        printf("%c", $1)
}
' > /home/chrstnamelia/Documents/decrypted_"$1$2"

cronjob
* * * * * /bin/bash /home/chrstnamelia/Documents/soal4enkripsi.sh
```
Tahap pertama yaitu mengubah isi dari var/syslog kedalam bentuk ASCII untuk mempermudah penamaan file back up. Pertama, isi dari /var/log/syslog diubah dengan hexdump, kemudian dengan fungsi hex2dec, bilangan hexadesimal diubah bentuk. Untuk penamaan, bilangan decimal dikurang 65 untuk uppercase dan dikurang 97 untuk lowercase. Setelah itu,hasilnya dimodulus 26 karena alfabet terdiri atas 26 huruf. Kemudian hasilnya ditambahkan 65 untuk Uppercase dan 97 unutk lowercase untuk mengembalikan ke bentuk ASCII.

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

awk '{ if (tolower($0) ~ /cron/ && tolower($0) !~ /sudo/ && NF <13) print $0}' /var/log/syslog >> /home/ariefp/syslogno5.log

2-30/6 * * * * /bin/bash /home/arief/nomor5.sh
 
```
Untuk mengecek apakah mengandung 'cron', maka digunakan `$0 ~ /cron/ || $0 ~ /CRON/` dimana cron secara penulisan ada 2 kemungkinan yakni cron dan CRON. Lalu kemudian tidak mengandung sudo, maka digunakan $0 `!~ /sudo/` dan untuk syarat yang terakhir yaitu jumlah fieldnya kurang dari 13 `NF < 13`. Kemudian hasilnya disimpan dalam /home/ariefp/modul1/syslog5.log


