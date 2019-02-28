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
