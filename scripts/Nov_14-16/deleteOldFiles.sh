#!/bin/bash

read -p "Enter Path:" n
find $n -type f -mtime +90 -exce rm -rf {} \

# crontab -e
# 0 10 * * * path to script(/root/scripts/deleteOldFiles.sh)
