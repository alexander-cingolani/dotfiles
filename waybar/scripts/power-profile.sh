#!/bin/bash
# Toggle or display the current ACPI platform profile

PROF_FILE="/sys/firmware/acpi/platform_profile"
CURRENT=$(cat "$PROF_FILE")

# Mapping icons
declare -A icons
icons["low-power"]="󰾆"
icons["balanced"]="󰾅"
icons["performance"]="󰓅"

if [[ "$1" == "--toggle" ]]; then
    case "$CURRENT" in
    low-power) NEXT="balanced" ;;
    balanced) NEXT="performance" ;;
    performance) NEXT="low-power" ;;
    *) NEXT="balanced" ;;
    esac

    sudo tee "$PROF_FILE" <<<"$NEXT" >/dev/null

else
    # JSON output for Waybar
    ICON="${icons[$CURRENT]:-󰾆}"
    printf '{"text": "%s", "tooltip": "Current Profile: %s", "class": "%s"}\n' "$ICON" "$CURRENT" "$CURRENT"
fi
