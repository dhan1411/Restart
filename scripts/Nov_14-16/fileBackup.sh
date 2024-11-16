#!/bin/bash

date=$(date +%d%m%Y)
read -p "enter directory:" n
for i in $(ls $n)
do
	cp $n/$i /tmp/${i]_$date
	
done
