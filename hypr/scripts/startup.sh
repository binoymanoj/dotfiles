#!/bin/bash

# Startup Script (as the name suggests it runs when starting up the system)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj
# 
# not using this script currently, you can use it if you find it useful

# Wait for Hyprland to fully start
sleep 2

# Move to workspace 10
hyprctl dispatch workspace 10

# Launch your application
ticktick &

# Moveback to workspace 1
# hyprctl dispatch workspace 1
