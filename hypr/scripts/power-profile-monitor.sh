#!/bin/bash
# Monitor the ACPI platform profile and send notifications on change

PROF_FILE="/sys/firmware/acpi/platform_profile"

declare -A icons
icons["low-power"]="󰾆"
icons["balanced"]="󰾅"
icons["performance"]="󰓅"

send_notification() {
    local profile=$1
    local icon=${icons[$profile]:-󰾆}
    notify-send -u normal -a "power-profile" "$icon  Power Profile" "Current profile: $profile" &
}

LAST_STATE=$(cat "$PROF_FILE")

while true; do
    if [ ! -f "$PROF_FILE" ]; then
        exit 1
    fi

    CURRENT_STATE=$(cat "$PROF_FILE")

    if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
        send_notification "$CURRENT_STATE"
        LAST_STATE=$CURRENT_STATE
    fi

    sleep 1
done
