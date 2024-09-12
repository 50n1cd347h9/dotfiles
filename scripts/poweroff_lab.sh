#!/bin/sh

export TOR_MAC="Whonix-Gateway-CLI"
export KALI_MAC="kali"

VBoxManage controlvm $TOR_MAC poweroff
VBoxManage controlvm $KALI_MAC poweroff
