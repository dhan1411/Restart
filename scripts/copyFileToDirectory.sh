#!/bin/bash

dir=$1
file=$2

if [ -d $dir ]
then
	if [ -f $file ]
	then
		cp $file $dir
		if [ $? -eq 0 ]
		then
			echo "File copied successfully"

		fi
	else
		echo "File does not exist"
	fi

else
	echo "directory does not exists"

fi

