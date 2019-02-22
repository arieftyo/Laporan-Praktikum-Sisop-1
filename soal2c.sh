awk -F ',' '{if(($7=="2012") && ($1=="United States") && ($4=="Personal Accessories" || $4 == "Outdoor Protection" || $4 =="Mountaineering Equipment")) produk[$6]+=$10} END {for(x in produk)print x}' WA_Sales_Products_2012-14.csv | sort -r | head -3

