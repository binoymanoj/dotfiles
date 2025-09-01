#!/bin/bash

# Hyprsunset Script (for night light - keymap in hyprland.conf)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Function to check if hyprsunset is running
is_running() {
    pgrep -x hyprsunset > /dev/null
}

# Function to start hyprsunset
start_hyprsunset() {
    killall hyprsunset 
    sleep 0.1 
    
    hyprsunset -t 3000k &
}

# Function to stop hyprsunset
stop_hyprsunset() {
    killall hyprsunset
}

case "$1" in
    "toggle")
        if is_running; then
            echo "if"
            stop_hyprsunset
            echo "if2"
            notify-send "Night Light" "Disabled" -i display-brightness
        else
            echo "else"
            start_hyprsunset
            echo "else2"
            notify-send "Night Light" "Enabled" -i display-brightness
        fi
        ;;
    "status")
        if is_running; then
            echo "{\"text\": \"󰖔\", \"class\": \"on\", \"tooltip\": \"Night Light: ON (3000K)\"}"
        else
            echo "{\"text\": \"󰖨\", \"class\": \"off\", \"tooltip\": \"Night Light: OFF\"}"
        fi
        ;;
esac
