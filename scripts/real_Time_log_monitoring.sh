#!/bin/bash

tail -f /var/log/syslog |grep --line-buffered "Error" | \
	while read -r line;
	do
		echo "$line"| \
			mail -s "Error occured in System" dhanashree.bhoyar@gmail.com;
		done
