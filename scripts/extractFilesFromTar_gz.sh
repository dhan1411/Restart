#!/bin/bash

read -p " Enter file to be extracted: " n
read -p " Enter where to extract :" p
tar -xvzf $n -C $p

if [ $? -eq 0 ]
then
	echo " All files extracted "
else
	echo " Extraction not done check again "
fi

