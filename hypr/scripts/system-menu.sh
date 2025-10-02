#!/bin/bash
# Hyprland System Menu
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Terminal to use
TERMINAL="kitty"

# Browser to use
BROWSER="brave"

# Bookmarks directory
BOOKMARKS_DIR="$HOME/Documents/"
BOOKMARKS_FILE="$BOOKMARKS_DIR/bookmarks.txt"

# Main menu options
show_main_menu() {
    echo "󰀻 Apps"
    echo "󰒓 Tools"
    echo "󰏔 Install"
    echo "󰚰 Update"
    echo "󰆴 Remove"
    echo "󱐋 Performance"
    echo "󰖩 WiFi"
    echo "󰂯 Bluetooth"
    echo "󰔠 Time Tracker"
    echo "󰠮 Journal"
    echo "󰍉 Task Manager"
    echo "󰖟 Bookmarks"
    echo "󰌌 Keybinds"
    echo "󰋗 About"
    echo "󰐥 System"
}

# Apps menu
show_apps() {
    rofi -show drun -i
}

# Tools menu
show_tools() {
    TOOL=$(echo -e "󰹑 Screenshot Area\n󰹑 Screenshot Full\n󰈋 Color Picker\n󰅖 Clipboard Manager\n󰃨 Wallpaper Selector\n󰌌 Emoji Picker" | rofi -dmenu -i -p "Tools")
    
    case "$TOOL" in
        *"Screenshot Area")
            grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S').png
            ;;
        *"Screenshot Full")
            grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S').png
            ;;
        *"Color Picker")
            hyprpicker -a
            ;;
        *"Clipboard Manager")
            cliphist list | rofi -dmenu -i -p "Clipboard" | cliphist decode | wl-copy
            ;;
        *"Wallpaper Selector")
            ~/.config/hypr/scripts/wallpaper-selector.sh
            ;;
        *"Emoji Picker")
            rofi -show emoji -i
            ;;
    esac
}

# Install menu
show_install() {
    MANAGER=$(echo -e "󰏖 Pacman\n󰣇 Yay" | rofi -dmenu -i -p "Install with")
    
    case "$MANAGER" in
        *"Pacman")
            PACKAGE=$(pacman -Slq | rofi -dmenu -i -p "Install package")
            if [ -n "$PACKAGE" ]; then
                $TERMINAL -e bash -c "sudo pacman -S $PACKAGE --noconfirm; read -p 'Press enter to close...'"
            fi
            ;;
        *"Yay")
            PACKAGE=$(yay -Slq | rofi -dmenu -i -p "Install package")
            if [ -n "$PACKAGE" ]; then
                $TERMINAL -e bash -c "yay -S $PACKAGE --noconfirm; read -p 'Press enter to close...'"
            fi
            ;;
    esac
}

# Update menu
show_update() {
    MANAGER=$(echo -e "󰏖 Pacman\n󰣇 Yay" | rofi -dmenu -i -p "Update with")
    
    case "$MANAGER" in
        *"Pacman")
            $TERMINAL -e bash -c "sudo pacman -Syu --noconfirm; read -p 'Press enter to close...'"
            ;;
        *"Yay")
            $TERMINAL -e bash -c "yay -Syu --noconfirm; read -p 'Press enter to close...'"
            ;;
    esac
}

# Remove menu
show_remove() {
    # Get all installed packages (both pacman and AUR)
    PACKAGE=$(pacman -Qq | rofi -dmenu -i -p "Remove package")
    
    if [ -n "$PACKAGE" ]; then
        # Check if it's an AUR package
        if pacman -Qm | grep -q "^$PACKAGE "; then
            $TERMINAL -e bash -c "yay -R $PACKAGE; read -p 'Press enter to close...'"
        else
            $TERMINAL -e bash -c "sudo pacman -R $PACKAGE; read -p 'Press enter to close...'"
        fi
    fi
}

# Performance menu
show_performance() {
    PROFILE=$(echo -e "󰓅 Performance\n󰾅 Balanced\n󰾆 Power Saver" | rofi -dmenu -i -p "Power Profile")
    
    case "$PROFILE" in
        *"Performance")
            powerprofilesctl set performance
            notify-send "Power Profile" "Switched to Performance mode"
            ;;
        *"Balanced")
            powerprofilesctl set balanced
            notify-send "Power Profile" "Switched to Balanced mode"
            ;;
        *"Power Saver")
            powerprofilesctl set power-saver
            notify-send "Power Profile" "Switched to Power Saver mode"
            ;;
    esac
}

# WiFi menu
show_wifi() {
    ACTION=$(echo -e "󰖩 Connect/Disconnect\n󰖩 Turn On\n󰖪 Turn Off\n󰑓 Restart" | rofi -dmenu -i -p "WiFi")
    
    case "$ACTION" in
        *"Connect/Disconnect")
            # Get list of networks
            NETWORK=$(nmcli -f SSID,SIGNAL,SECURITY device wifi list | tail -n +2 | rofi -dmenu -i -p "Select Network")
            if [ -n "$NETWORK" ]; then
                SSID=$(echo "$NETWORK" | awk '{print $1}')
                # Check if already connected
                if nmcli connection show --active | grep -q "$SSID"; then
                    nmcli connection down "$SSID"
                    notify-send "WiFi" "Disconnected from $SSID"
                else
                    PASSWORD=$(rofi -dmenu -password -p "Password for $SSID")
                    if [ -n "$PASSWORD" ]; then
                        nmcli device wifi connect "$SSID" password "$PASSWORD"
                        notify-send "WiFi" "Connected to $SSID"
                    fi
                fi
            fi
            ;;
        *"Turn On")
            nmcli radio wifi on
            notify-send "WiFi" "WiFi turned on"
            ;;
        *"Turn Off")
            nmcli radio wifi off
            notify-send "WiFi" "WiFi turned off"
            ;;
        *"Restart")
            nmcli radio wifi off && sleep 2 && nmcli radio wifi on
            notify-send "WiFi" "WiFi restarted"
            ;;
    esac
}

# Bluetooth menu
show_bluetooth() {
    ACTION=$(echo -e "󰂯 Connect/Disconnect\n󰂯 Turn On\n󰂲 Turn Off\n󰑓 Restart" | rofi -dmenu -i -p "Bluetooth")
    
    case "$ACTION" in
        *"Connect/Disconnect")
            # Get list of paired devices
            DEVICE=$(bluetoothctl devices | rofi -dmenu -i -p "Select Device")
            if [ -n "$DEVICE" ]; then
                MAC=$(echo "$DEVICE" | awk '{print $2}')
                # Check if connected
                if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
                    bluetoothctl disconnect "$MAC"
                    notify-send "Bluetooth" "Disconnected from device"
                else
                    bluetoothctl connect "$MAC"
                    notify-send "Bluetooth" "Connected to device"
                fi
            fi
            ;;
        *"Turn On")
            bluetoothctl power on
            notify-send "Bluetooth" "Bluetooth turned on"
            ;;
        *"Turn Off")
            bluetoothctl power off
            notify-send "Bluetooth" "Bluetooth turned off"
            ;;
        *"Restart")
            bluetoothctl power off && sleep 2 && bluetoothctl power on
            notify-send "Bluetooth" "Bluetooth restarted"
            ;;
    esac
}

# Journal
show_journal() {
    ENTRY=$(echo -e "󰃭 Today\n󰃮 Tomorrow" | rofi -dmenu -i -p "Journal")
    
    case "$ENTRY" in
        *"Today")
            ~/.config/hypr/scripts/journal/today 
            notify-send "Journal" "Opening today's journal"
            ;;
        *"Tomorrow")
            ~/.config/hypr/scripts/journal/tomorrow
            notify-send "Journal" "Opening tomorrow's journal"
            ;;
    esac
}

# Time Tracker
show_timetracker() {
    ~/.config/hypr/scripts/timetracker.sh
}

# Task Manager
show_task_manager() {
    $TERMINAL -e btop
}

detect_browser() {
    for b in brave brave-browser google-chrome chromium firefox; do
        if command -v "$b" >/dev/null 2>&1; then
            echo "$b"
            return
        fi
    done
    echo ""  
}

# Sync bookmarks from Brave (tab-separated file: Title <TAB> URL)
sync_bookmarks() {
    mkdir -p "$BOOKMARKS_DIR"

    BRAVE_BOOKMARKS="$HOME/.config/BraveSoftware/Brave-Browser/Default/Bookmarks"
    if [ ! -f "$BRAVE_BOOKMARKS" ]; then
        notify-send "Bookmarks" "Brave bookmarks file not found!"
        return
    fi

    # Produce TAB-separated lines: Title<TAB>URL
    # - use // "" to avoid null names, gsub to remove tabs from names
    jq -r '.. | objects
             | select(.type == "url")
             | ( (.name // "") | gsub("\t"; " ") ) + "\t" + .url
           ' "$BRAVE_BOOKMARKS" > "$BOOKMARKS_FILE"

    BOOKMARK_COUNT=$(wc -l < "$BOOKMARKS_FILE" | tr -d ' ')
    notify-send "Bookmarks" "Synced $BOOKMARK_COUNT bookmarks from Brave"
}

# Show bookmarks menu (uses arrays to map display -> URL)
show_bookmarks() {
    mkdir -p "$BOOKMARKS_DIR"

    if [ ! -f "$BOOKMARKS_FILE" ]; then
        ACTION=$(echo -e "󰓦 Sync Bookmarks from Browser" | rofi -dmenu -i -p "Bookmarks")
        if [[ "$ACTION" == *"Sync"* ]]; then
            sync_bookmarks
            show_bookmarks
        fi
        return
    fi

    # Read lines into array
    mapfile -t _lines < "$BOOKMARKS_FILE"

    # Build display array and url array in parallel
    display_lines=()
    urls=()
    for line in "${_lines[@]}"; do
        # split on first tab
        title="${line%%$'\t'*}"
        url="${line#*$'\t'}"
        if [ -z "$title" ]; then
            display_name=$(echo "$url" | sed 's|https\?://||; s|www\.||' | cut -c1-50)
        else
            display_name="$title"
        fi
        display_lines+=("$display_name")
        urls+=("$url")
    done

    # Prepend sync option
    MENU=$(printf "%s\n" "󰓦 Sync Bookmarks from Browser" "${display_lines[@]}")

    SELECTION=$(echo -e "$MENU" | rofi -dmenu -i -p "Bookmarks")
    if [ -z "$SELECTION" ]; then
        return
    fi

    if [[ "$SELECTION" == *"Sync Bookmarks"* ]]; then
        sync_bookmarks
        show_bookmarks
        return
    fi

    # Find selected index (first match). This will pick the first duplicate if there are duplicates.
    found_index=-1
    for i in "${!display_lines[@]}"; do
        if [ "${display_lines[$i]}" = "$SELECTION" ]; then
            found_index=$i
            break
        fi
    done

    if [ "$found_index" -ge 0 ]; then
        FOUND_URL="${urls[$found_index]}"
        BROWSER_CMD=$(detect_browser)
        if command -v xdg-open >/dev/null 2>&1; then
            xdg-open "$FOUND_URL" 2>/dev/null || { [ -n "$BROWSER_CMD" ] && "$BROWSER_CMD" "$FOUND_URL" & }
        else
            if [ -n "$BROWSER_CMD" ]; then
                "$BROWSER_CMD" "$FOUND_URL" &
            else
                notify-send "Bookmarks" "No browser found to open URL"
            fi
        fi
        notify-send "Bookmarks" "Opening bookmark"
    else
        notify-send "Bookmarks" "Could not find URL for bookmark"
    fi
}

# Keybinds menu
show_keybinds() {
    ~/.config/hypr/scripts/keymap-menu.sh
}

# About
show_about() {
    $TERMINAL -e bash -c "fastfetch; read -p 'Press enter to close...'"
}

# System menu (existing power menu)
show_system() {
    ~/.config/hypr/scripts/power-menu.sh
}

# Main logic
CHOICE=$(show_main_menu | rofi -dmenu -i -p "System Menu")

case "$CHOICE" in
    *"Apps")
        show_apps
        ;;
    *"Tools")
        show_tools
        ;;
    *"Install")
        show_install
        ;;
    *"Update")
        show_update
        ;;
    *"Remove")
        show_remove
        ;;
    *"Performance")
        show_performance
        ;;
    *"WiFi")
        show_wifi
        ;;
    *"Bluetooth")
        show_bluetooth
        ;;
    *"Time Tracker")
        show_timetracker
        ;;
    *"Journal")
        show_journal
        ;;
    *"Task Manager")
        show_task_manager
        ;;
    *"Bookmarks")
        show_bookmarks
        ;;
    *"Keybinds")
        show_keybinds
        ;;
    *"About")
        show_about
        ;;
    *"System")
        show_system
        ;;
esac
