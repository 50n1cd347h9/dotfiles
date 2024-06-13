#!/bin/bash

exist_alacritty() {
    IF_EXIST=$(swaymsg -s $SWAYSOCK -t get_tree | grep Alacritty | wc -l)
    if [ "$IF_EXIST" -gt 0 ]; then
		return 0
	else
		return 1
	fi
}

while true; do
	if exist_alacritty; then
		swaymsg -s $SWAYSOCK '[class="Alacritty"] focus; move right'
		break
	fi
	sleep 1
done
