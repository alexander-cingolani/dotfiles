#!/bin/bash

# Get the list of all players (sorted alphabetically for a stable index)
players=$(playerctl -l | sort)

# Get the name of the currently active player from playerctld
# We use the metadata from the default player chosen by playerctl/playerctld
active_player=$(playerctl metadata --format "{{playerName}}" 2>/dev/null)

if [ -z "$active_player" ]; then
    echo ""
    exit 0
fi

# Count total players
total_count=$(echo "$players" | wc -l)

# Find the index of the active player (1-based)
# We use a regex to match the player name as a prefix (handles instances like chromium.instance123)
player_index=$(echo "$players" | grep -nE "^$active_player(\.|$)" | cut -d: -f1 | head -n 1)

if [ -z "$player_index" ]; then
    echo ""
else
    echo "[$player_index/$total_count]"
fi
