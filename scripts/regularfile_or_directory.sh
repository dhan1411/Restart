#!/bin/bash



if [ -f $1 ] 
then
	echo "This is a regular file"
      
elif [ -d $1 ]
then
	echo "this is a directory"
else
	echo "this not regular file nor directory"
fi
