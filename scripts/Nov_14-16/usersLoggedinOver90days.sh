#!/bin/bash

#List the users
cat /etc/passwd

#90Daysago_date
daysago=$(date --date="90 days ago" +"%b %d")

last | awk '{print $1, $5, $6}'|grep $daysago| cut -d ' ' -f 1 >> Usersloggedin90DaysAgo.txt 
