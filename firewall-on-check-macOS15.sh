#!/bin/bash

# Path to alf file
alf="/Library/Preferences/com.apple.alf.plist"

# system profiler data
syspro=$(/usr/sbin/system_profiler SPFirewallDataType -detailLevel basic |grep Limit)

# Check if alf file exists
if [ ! -f "$alf" ]; then
    echo "$syspro"
    exit 0
fi

# Check firewall status
firewall=$(defaults read /Library/Preferences/com.apple.alf globalstate)

if [ "$firewall" = "1" ]; then
    echo "Firewall is enabled"
elif [ "$firewall" = "0" ]; then
    # Set firewall status
    #defaults write /Library/Preferences/com.apple.alf globalstate -int 0
    echo "$syspro"
else
    echo "Unable to determine firewall status"
fi
