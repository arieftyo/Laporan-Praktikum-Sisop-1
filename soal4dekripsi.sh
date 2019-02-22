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

