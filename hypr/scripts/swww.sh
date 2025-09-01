#!/bin/bash

# SWWW Script (for wallpaper management)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj
# 
# currently not using this, instead I use waypaper for managing wallpapers

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Start swww daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww init
    sleep 1
fi

# Pick a random wallpaper
wallpaper=$(find "$WALLPAPER_DIR" -type f | shuf -n1)

# Set wallpaper with transition effect
swww img "$wallpaper" --transition-type any --transition-step 30 --transition-fps 60
