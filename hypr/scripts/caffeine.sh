#!/bin/bash

# Caffeine Script (for keeping the screen awake - keymap in hyprland.conf)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

CAFFEINE_STATE_FILE="/tmp/caffeine_state"

status() {
    if [ -f "$CAFFEINE_STATE_FILE" ]; then
        echo '{"text": "󰅶", "tooltip": "Caffeine Mode: Active", "class": "on"}'
    else
        echo '{"text": "", "tooltip": "Caffeine Mode: Inactive", "class": "off"}'
    fi
}

toggle() {
    if [ -f "$CAFFEINE_STATE_FILE" ]; then
        rm "$CAFFEINE_STATE_FILE"
        pkill -SIGUSR1 hypridle  # Restart hypridle
        notify-send -i caffeine-off "󰅶 Caffeine Mode" "Disabled" -h string:x-canonical-private-synchronous:caffeine
    else
        touch "$CAFFEINE_STATE_FILE"
        pkill hypridle  # Stop hypridle
        notify-send -i caffeine-on "󰅶 Caffeine Mode" "Enabled" -h string:x-canonical-private-synchronous:caffeine
    fi
}

case "$1" in
    "status")
        status
        ;;
    "toggle")
        toggle
        ;;
esac
