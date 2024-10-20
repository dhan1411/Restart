#!/bin/bash

read -p "Enter filename:" n
if [ -f $n ]
then
	cat $n | head -n 10
else
	echo "File does not exist"
fi
