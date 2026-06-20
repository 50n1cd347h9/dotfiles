#!/bin/env bash

if [ -d ./nvim ]; then
	echo "./nvim already exists."
	exit 0
fi

mkdir nvim
cp -a $(realpath .)/../../.config/nvim/init.lua nvim/


sed -i -E 's/(vim\.opt\.rtp:prepend\(")[^"]*("\))/\1\/root\/\.config\/nvim\/fudebako\.nvim\2/' nvim/init.lua
