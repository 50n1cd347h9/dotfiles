#!/bin/bash

DIRECTORY="$(pwd)"

LINKED=$(find ${DIRECTORY} -type l | \
        awk '{ gsub("/", " "); gsub(".pdf|.epub", ""); print $NF }' | \
        uniq
)

# include extension
ALL=$(find ${DIRECTORY}/book_* | \
        awk '{ gsub("/", " "); print $NF }' | \
        uniq
)

if [ -z $LINKED ]; then
        echo "$ALL"
else
        echo "$ALL" | grep -v "$LINKED"
fi
