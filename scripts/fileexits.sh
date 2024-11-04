#!/bin/bash


if [ -f $1 ]
then
	echo " It is a file "
	if [ -r $1 ]
	then
		echo " File is readable"
	else
		echo " File is not readable"
	fi
	if [ -w $1 ]
	then
		echo " file is writable"
	else
		echo " File is not writable"
	fi

	if [ -x $1 ]
	then
		echo " file is executable "
	else
		echo " File is not executable "
	fi
	
else
	echo "It's not a file"

fi

