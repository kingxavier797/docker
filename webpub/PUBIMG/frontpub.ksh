#!/bin/sh
x=1
for all in `ls banner*[1-9].jpg`
do
cp $all frontpub-${x}.jpg
x=$(($x+1))
done
