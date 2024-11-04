#!/bin/bash

read -p " Enter directory:" n
 
cd $n

tar -cvzf /c/Users/dhana/scripts/test.tar.gz *log

if [ $? -eq 0 ]
then
	echo " All log files in $n directory are archieved and compressed "
else
	echo "Something wrong in script"
fi


