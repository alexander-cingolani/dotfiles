#!/bin/bash

# Find the first battery and AC device
BAT=$(ls /sys/class/power_supply/ | grep '^BAT' | head -n 1)
AC=$(ls /sys/class/power_supply/ | grep '^AC' | head -n 1)
STATE_FILE="/tmp/tlp-fullcharge-active"

if [ -z "$BAT" ]; then
    exit 0
fi

CAPACITY=$(cat "/sys/class/power_supply/$BAT/capacity")
STATUS=$(cat "/sys/class/power_supply/$BAT/status")
AC_ONLINE=$(cat "/sys/class/power_supply/$AC/online" 2>/dev/null || echo 0)

# Calculate remaining time (energy / power) using awk
TIME_STR=""
if [ -f "/sys/class/power_supply/$BAT/energy_now" ] && [ -f "/sys/class/power_supply/$BAT/power_now" ]; then
    ENERGY_NOW=$(cat "/sys/class/power_supply/$BAT/energy_now")
    ENERGY_FULL=$(cat "/sys/class/power_supply/$BAT/energy_full")
    POWER_NOW=$(cat "/sys/class/power_supply/$BAT/power_now")

    # Only calculate if power draw is significant (> 0.1W)
    if [ "$POWER_NOW" -gt 100000 ]; then
        if [[ "$STATUS" == "Discharging" ]]; then
            TIME_STR=$(awk "BEGIN {h=$ENERGY_NOW/$POWER_NOW; hrs=int(h); mins=int((h-hrs)*60); if(hrs>0) printf \"%dh %dm\", hrs, mins; else printf \"%dm\", mins}")
        elif [[ "$STATUS" == "Charging" ]]; then
            TIME_STR=$(awk "BEGIN {h=($ENERGY_FULL-$ENERGY_NOW)/$POWER_NOW; hrs=int(h); mins=int((h-hrs)*60); if(hrs>0) printf \"%dh %dm\", hrs, mins; else printf \"%dm\", mins}")
        fi
    fi
fi

# Logic for Icon and Status
if [ "$AC_ONLINE" -eq 1 ]; then
    ICON="󰚥"

    # DETERMINE STATE based on toggle intent
    if [ -f "$STATE_FILE" ]; then
        if [[ "$STATUS" == "Full" ]]; then
            STATE="plugged"
        else
            STATE="charging"
        fi
    else
        # Capped mode is active (65%)
        if [[ "$STATUS" == "Charging" ]] && [ "$CAPACITY" -le 66 ]; then
            STATE="charging"
        else
            STATE="plugged"
        fi
    fi

    # Format the text based on the determined state
    if [[ "$STATE" == "charging" ]]; then
        if [ -z "$TIME_STR" ]; then
            TEXT="󰚥 <tt>$CAPACITY% (estimating...)</tt>"
            TOOLTIP="Charging: waiting for hardware estimate..."
        else
            TEXT="󰚥 <tt>$CAPACITY% ($TIME_STR)</tt>"
            TOOLTIP="Charging: $TIME_STR"
        fi
    else
        STATE="plugged"
        TEXT="󰚥 <tt>$CAPACITY%</tt>"
        TOOLTIP="Plugged in ($STATUS)"
    fi
else
    # Discharging
    STATE="discharging"
    TOOLTIP="Discharging: $TIME_STR"
    if [ "$CAPACITY" -le 15 ]; then
        ICON="󰂎"
    elif [ "$CAPACITY" -le 30 ]; then
        ICON="󰁻"
    elif [ "$CAPACITY" -le 60 ]; then
        ICON="󰁾"
    elif [ "$CAPACITY" -le 90 ]; then
        ICON="󰂀"
    else
        ICON="󰁹"
    fi
    TEXT="$ICON <tt>$CAPACITY%</tt>"
fi

# Determine CSS class for states
CLASS="${STATE,,// /-}"
if [ "$CAPACITY" -le 15 ]; then
    CLASS="$CLASS critical"
elif [ "$CAPACITY" -le 30 ]; then
    CLASS="$CLASS warning"
fi

# Output JSON for Waybar
printf '{"text": "%s", "tooltip": "%s", "class": "%s", "percentage": %d}\n' "$TEXT" "$TOOLTIP" "$CLASS" "$CAPACITY"
