awk -F, '{if($7 == '2012' && $1=="United States") iter[$4]+=$10} END {for(hasil in iter) {print iter[hasil], hasil}}' WA_Sales_Products_2012-14.csv | sort -nr | head -n3 | awk -F, '{print $2}'

