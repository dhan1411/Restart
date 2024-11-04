#!/bin/bash

x=$(du -sm $1|awk '{print $1}')

if [ $x -ge 100 ]
then
	echo "Directory space is greater than equal 100M " |mail -s "Directory highly utilized" dhanashree.bhoyar@gmail.com
else
	echo "Directory usage is within limit you can add files"

fi

        

