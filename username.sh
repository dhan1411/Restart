#!/bin/bash

read -p "Enter username:" n

cat /etc/passwd | grep $n >>/dev/null

if [ $? -eq 0 ]
then
	echo "$n user exists"
else
	echo "$n user is not present"

fi
