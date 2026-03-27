#!/bin/bash
# Toggle TLP fullcharge on/off. Only acts when AC is connected.

STATE_FILE="/tmp/tlp-fullcharge-active"

# Check if any AC adapter is online
if ! grep -q 1 /sys/class/power_supply/AC*/online 2>/dev/null; then
    exit 0
fi

if [ -f "$STATE_FILE" ]; then
    sudo tlp setcharge && rm "$STATE_FILE"
else
    sudo tlp fullcharge && touch "$STATE_FILE"
fi
