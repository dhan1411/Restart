#!/bin/bash

logfile=$1
Template=$(sed "s|PathtoLogFile|$logfile|g" /c/Users/dhana/scripts/template.txt)


echo " $Template " > /etc/logrotate.d/$lofgile
logrotate -f /etc/logrotate.d
