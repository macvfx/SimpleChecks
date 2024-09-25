#!/bin/bash

# Check firewall status
firewall=$(defaults read /Library/Preferences/com.apple.alf globalstate)

if [ "$firewall" = "1" ]; then
    echo "Firewall is enabled"
elif [ "$firewall" = "0" ]; then
    # Set firewall status
    #defaults write /Library/Preferences/com.apple.alf globalstate -int 0
    echo "Firewall is NOT enabled"
else
    echo "Unable to determine firewall status"
fi