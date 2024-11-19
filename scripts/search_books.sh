#!/usr/bin/env bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 'word'"
	exit 1
fi

find -L  ./  -type f -name "*threat*"

# for dir in */; do
# 	if [ -d "$dir" ]; then
# 		ls "$dir" | \
# 		grep "$1" | \
# 		awk -v dir_name="$dir" '{
# 			for (i = 1; i <= NF; i++) {
# 				print dir_name $i
# 			}
# 		}'
# 	fi
# done
