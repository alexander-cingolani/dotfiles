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

# Multi-stage refresh strategy:
# 1. Instant (0.1s) for immediate UI feedback (colors)
(sleep 0.1 && pkill -SIGRTMIN+8 waybar) &

# 2. Sequential background refreshes to catch the hardware estimate (2s, 5s, 10s)
(for s in 2 5 10; do sleep $s; pkill -SIGRTMIN+8 waybar; done) &
