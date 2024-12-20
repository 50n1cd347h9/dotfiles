#!/bin/sh
export DEBUGGER_MAC="7ada46c2-98df-478a-a6ac-efae6e2157c9"
VirtualBoxVM --startvm $DEBUGGER_MAC > /dev/null 2>&1 &
