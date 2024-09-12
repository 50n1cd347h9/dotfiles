#!/bin/sh

export TOR_MAC="Whonix-Gateway-CLI"
export KALI_MAC="kali"

VBoxHeadless --startvm $TOR_MAC > /dev/null 2>&1 &
VirtualBoxVM --startvm $KALI_MAC > /dev/null 2>&1 &
