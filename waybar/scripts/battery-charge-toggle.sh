#!/bin/bash
# Toggle TLP fullcharge on/off. Only acts when AC is connected.

STATE_FILE="/tmp/tlp-fullcharge-active"

# Check if any AC adapter is online
if ! grep -q 1 /sys/class/power_supply/AC*/online 2>/dev/null; then
    exit 0
fi

if [ -f "$STATE_FILE" ]; then
    if sudo tlp setcharge; then
        rm "$STATE_FILE"
        notify-send -u normal -t 3000 -i battery-good-symbolic "Battery Cap Reinstated" "Charging capped at 65%.\n(Will charge up to 65% if currently below)"
    fi
else
    if sudo tlp fullcharge; then
        touch "$STATE_FILE"
        notify-send -u normal -t 3000 -i battery-full-charged-symbolic "Battery Cap Removed" "Charging to 100%."
    fi
fi
