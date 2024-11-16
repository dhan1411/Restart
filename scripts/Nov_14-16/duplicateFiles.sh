#!/bin/bash

read -p "Enter path in which you want to view duplicate files:" n
find $n -type f -size 10M -exec chksum {} \;|sort |uniq -w 10 -D

