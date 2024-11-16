#!/bin/bash


ports=(80 443)
for port in "${ports[@]}"
do
    netstat -putan |grep ":${port}" >> serverlist.txt
    if [ $? -eq 0 ]
    then
        echo " $port is Open "
    else
        echo " $port is Closed"
    fi
done
