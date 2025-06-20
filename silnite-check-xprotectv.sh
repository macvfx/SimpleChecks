#!/bin/bash

LOG_DIR="/Users/Shared"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/silcheck-log-$DATE.txt"

/usr/local/bin/silnite > "/Users/Shared/silnite-xprotectv-$DATE.json"
VERSION=$(/usr/bin/plutil -extract XProtectV raw "/Users/Shared/silnite-xprotectv-$DATE.json")

echo "$VERSION" | tee -a "$LOG_FILE"
