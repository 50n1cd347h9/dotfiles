#!/bin/bash

if [ $# -eq 0 ]; then
	echo "usage: $0 <ip or name>"
	exit 1
fi

while :
do
	nvim --listen ${1}:22222 --headless 
	# 2>&1 &
done
