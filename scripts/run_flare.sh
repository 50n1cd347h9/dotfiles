#!/bin/sh

export FLARE_MAC="flare-vm"

VirtualBoxVM --startvm $FLARE_MAC > /dev/null 2>&1 &
