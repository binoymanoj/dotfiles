#!/bin/bash

# Wallpaper Selector
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Configuration
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
HYPRPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"
CACHE_DIR="$HOME/.cache/rofi-wallpaper"
THUMBNAIL_SIZE="200x112"

# Create directories if they don't exist
mkdir -p "$CACHE_DIR"
mkdir -p "$(dirname "$HYPRPAPER_CONFIG")"

# Generate thumbnails for wallpapers that don't have them
generate_thumbnails() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" \) | while read -r wallpaper; do
        filename=$(basename "$wallpaper")
        thumbnail="$CACHE_DIR/${filename%.*}_thumb.jpg"
        
        # Generate thumbnail if it doesn't exist
        if [[ ! -f "$thumbnail" ]]; then
            if command -v convert >/dev/null 2>&1; then
                convert "$wallpaper" -resize "$THUMBNAIL_SIZE^" -gravity center -extent "$THUMBNAIL_SIZE" -quality 85 "$thumbnail" 2>/dev/null
            elif command -v magick >/dev/null 2>&1; then
                magick "$wallpaper" -resize "$THUMBNAIL_SIZE^" -gravity center -extent "$THUMBNAIL_SIZE" -quality 85 "$thumbnail" 2>/dev/null
            fi
        fi
    done
}

# Create rofi entries with thumbnails
create_rofi_entries() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" \) | sort | while read -r wallpaper; do
        filename=$(basename "$wallpaper")
        display_name="${filename%.*}"
        thumbnail="$CACHE_DIR/${filename%.*}_thumb.jpg"
        
        if [[ -f "$thumbnail" ]]; then
            printf "%s\x00icon\x1f%s\x1finfo\x1f%s\n" "$display_name" "$thumbnail" "$wallpaper"
        else
            printf "%s\x00info\x1f%s\n" "$display_name" "$wallpaper"
        fi
    done
}

# Set wallpaper using hyprpaper
set_wallpaper() {
    local relative_path="$1"
    
    # Update hyprpaper config
    cat > "$HYPRPAPER_CONFIG" << EOF
# Hyprpaper Configuration
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj
# Last Updated: $(date '+%Y-%m-%d')

preload = ${relative_path}
wallpaper = ,${relative_path}
EOF
    
    # Reload hyprpaper
    pkill hyprpaper 2>/dev/null
    sleep 0.5
    hyprpaper > /dev/null 2>&1 &
    
    # Send notification
    if command -v notify-send >/dev/null 2>&1; then
        # Convert back to full path for notification icon
        local full_path="${relative_path/#\~/$HOME}"
        notify-send "Wallpaper Changed" "$(basename "$full_path")" --icon="$full_path" --expire-time=3000 2>/dev/null
    fi
}
# Main execution
main() {
    # Check if wallpaper directory exists
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        notify-send "Error" "Wallpaper directory not found: $WALLPAPER_DIR" --urgency=critical 2>/dev/null
        exit 1
    fi
    
    # Generate thumbnails
    generate_thumbnails
    
    # Show rofi selector and get the selection
    selected=$(create_rofi_entries | rofi -dmenu -i -p "🎨 Select Wallpaper" -show-icons -format 's' -theme-str '
window {
    width: 70%;
    height: 60%;
}
listview {
    columns: 4;
    lines: 3;
    scrollbar: false;
    flow: horizontal;
}
element {
    orientation: vertical;
    padding: 10px;
    margin: 5px;
}
element-icon {
    size: 200px;
    border-radius: 8px;
}
element-text {
    horizontal-align: 0.5;
    margin: 5px 0 0 0;
}')
    
    # Process selection
    if [[ -n "$selected" ]]; then
        # Find the corresponding wallpaper file by matching display name
        wallpaper_path=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" \) | while read -r wallpaper; do
            filename=$(basename "$wallpaper")
            file_display_name="${filename%.*}"
            if [[ "$file_display_name" == "$selected" ]]; then
                # Convert to relative path by replacing $HOME with ~
                echo "$wallpaper" | sed "s|^$HOME|~|"
                break
            fi
        done)
        
        if [[ -n "$wallpaper_path" ]]; then
            set_wallpaper "$wallpaper_path"
        else
            notify-send "Error" "Wallpaper not found for selection: $selected" --urgency=critical 2>/dev/null
        fi
    fi
}

main
