#!/bin/bash

# Workflow Script (for opening all the workflow scripts I set in the ~/.config/scripts/workflow/ dir - keymap in hyprland.conf)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj
#
# very useful, I use this everyday

SCRIPT_DIR="$HOME/.config/scripts/workflow"

# List executable files only
SCRIPTS=$(find "$SCRIPT_DIR" -maxdepth 1 -type f -executable -printf "%f\n")

# Launch rofi to select a script
SELECTED=$(echo "$SCRIPTS" | rofi -dmenu -p "Run workflow:")

# Run the selected script, if any
if [ -n "$SELECTED" ]; then
    "$SCRIPT_DIR/$SELECTED"
fi
