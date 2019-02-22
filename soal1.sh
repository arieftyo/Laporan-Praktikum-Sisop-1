#!/bin/bash

for i in *.jpg
do
	base64 -d $i | xxd -r > /home/chrstnamelia/Documents/nature/tutu/$i
done

#terdapat file berbentuk .jpg yang terenkripsi. 'base64
