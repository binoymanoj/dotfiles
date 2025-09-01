#!/bin/bash

# Power Menu Script (keymap in hyprland.conf)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Options with icons (requires Font Awesome)
shutdown="⏻ Shutdown"
reboot="🔃 Reboot"
suspend="󰒲  Suspend"
lock="🔒 Lock"
logout="↩ Logout"

# Get answer from rofi
selected_option=$(echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/power.rasi)

# Do something based on selected option
case $selected_option in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$lock")
        # swaylock
        hyprlock
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
