#!/bin/bash

echo "top 5 memory consuming processes are below "
ps aux | sort -nr -k4 |head -n 5
