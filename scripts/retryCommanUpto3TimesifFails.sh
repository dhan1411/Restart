#!/bin/bash
read -p "Enter command:" n


for i in  {0..2}
do
		
		$n > /dev/null 2>&1   
		if [ $? -eq 0 ]
		then
			echo "Success "
			break
		        
		fi
		if [ $i -eq 2 ]
		then
			echo " failure of command after3 attempts "
		fi
done

