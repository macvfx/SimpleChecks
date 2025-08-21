#!/bin/bash

LOG_DIR="/Users/Shared"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/xprotect-check-log-$DATE.txt"

# Get local XProtect version
LOCAL_VERSION=$(/usr/bin/xprotect check | awk -F ':' '{print $6}' | xargs)

# Download SOFA JSON feed
SOFA_JSON="/tmp/sofa_xprotect.json"
curl -s "https://sofafeed.macadmins.io/v1/macos_data_feed.json" -o "$SOFA_JSON"

# Check if download succeeded
if [[ ! -s "$SOFA_JSON" ]]; then
    echo "$LOCAL_VERSION (Latest: ERROR: Could not download SOFA feed)" | tee -a "$LOG_FILE"
    exit 1
fi

# Extract latest XProtect version from SOFA feed
LATEST_VERSION=$(/usr/bin/plutil -extract "XProtectPlistConfigData.com\.apple\.XProtect" raw "$SOFA_JSON" | head -n 1 | xargs)

{
    echo "$LOCAL_VERSION (Latest: $LATEST_VERSION)"
} | tee -a "$LOG_FILE"
