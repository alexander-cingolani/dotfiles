#!/bin/bash
CLASS=$1
shift
if hyprctl clients -j | grep -q "\"class\": \"$CLASS\""; then
    hyprctl dispatch closewindow "class:^($CLASS)$"
else
    "$@" &
fi
