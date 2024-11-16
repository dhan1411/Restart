#!/bin/bash


tar -cvzf /mnt/backup/backup.tar.gz_$(date +"%Y-%m-%d) /home/user/data

# crontab -e
# 0 2 * * * /root/scripts/BackupDirectory.sh
