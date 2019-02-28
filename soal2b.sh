awk -F ',' '{if(($7=="2012") && ($1=="United States")) produk[$4]+=$10} END {for(x in produk)print x}' WA_Sales_Products_2012-14.csv | sort -nr | head -3
