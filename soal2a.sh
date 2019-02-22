awk -F ',' -v max=0 '{if($7=='2012' && $10>max){want=$1; max=$10}}END{print want} ' WA_Sales_Products_2012-14.csv

