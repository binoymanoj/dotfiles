#!/usr/bin/env bash

# Screenshot Script (for taking screenshot of entire window, no selection needed and it saves to clipboard and to the dir given below - keymap in hyprland.conf)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

DEST=~/Pictures/Screenshots
mkdir -p "$DEST"

timestamp=$(date +'%Y%m%d_%H%M%S')
tmpfile="/tmp/screenshot_$timestamp.png"

# Capture the focused output, copy to clipboard, and save to temp
grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" - | tee "$tmpfile" | wl-copy

# Save permanent file
mv "$tmpfile" "$DEST/$timestamp.png"

# Send notification with the screenshot as icon (preview), auto-closes after 5 s
notify-send -i "$DEST/$timestamp.png" -t 5000 "Screenshot captured" "Saved to $DEST/$timestamp.png"
