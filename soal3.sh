#!/bin/bash

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
