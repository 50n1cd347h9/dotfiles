#!/bin/bash

DIRECTORY="$(pwd)"

# find ${directory} -type l -exec readlink {} +

# find ${directory} -type l -exec readlink {} + | \
# 	awk '{ gsub("/", " "); print}'

LINKED=$(find ${DIRECTORY} -type l | \
	awk '{ gsub("/", " "); print $NF }')

ls ${DIRECTORY}/all | grep -v "$LINKED"
