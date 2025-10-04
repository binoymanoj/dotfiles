#!/bin/bash
# Hyprland Keymap Reference Menu
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Generate keymap list with icons and descriptions
show_keymaps() {
    cat << EOF
󰌌 SUPER + RETURN → Open Terminal
󰍉 SUPER + SPACE → Main Menu (System Menu)
󰖙 SUPER + C → Close Active Window
󰗼 SUPER + SHIFT + M → Exit Hyprland
󰖟 SUPER + B → Open Browser (Brave)
󰉋 SUPER + E → File Manager
󰉌 SUPER + Z → Toggle Floating
󰘶 SUPER + P → Pseudo Tiling
󰐃 SUPER + CTRL + P → Pin Window
󰯌 SUPER + SHIFT + I → Toggle Split
󰊓 SUPER + F → Fullscreen
󰊓 SUPER + SHIFT + F → Maximize (keeps gaps)
󰞅 SUPER + . → Emoji Picker
󰍉 ALT + SPACE → Rofi App Launcher
󰜉 SUPER + R → Smart Run/Search
󰇘 ALT + R → Rofi Run Commands
󰖯 ALT + TAB → Window Switcher
󰌾 SUPER + SHIFT + P → KeePassXC
󰐥 SUPER + SHIFT + Q → Power Menu
󰅖 SUPER + V → Clipboard History
󰅖 SUPER + SHIFT + V → Delete Clipboard Entry
󰅖 SUPER + SHIFT + ALT + V → Wipe Clipboard
󰝚 SUPER + M → Music Player
󰐊 SUPER + ALT + SPACE → Play/Pause Media
󰒮 SUPER + ALT + LEFT → Previous Track
󰒭 SUPER + ALT + RIGHT → Next Track
󰒮 SUPER + ALT + H → Previous Track
󰒭 SUPER + ALT + L → Next Track
󰕾 SUPER + ALT + UP → Volume Up
󰕿 SUPER + ALT + DOWN → Volume Down
󰕿 SUPER + ALT + J → Volume Down
󰕾 SUPER + ALT + K → Volume Up
󰖁 SUPER + ALT + M → Toggle Mute
󰍬 SUPER + ALT + D → Toggle Mic Mute
󰃞 SUPER + ALT + = → Brightness Up
󰃞 SUPER + ALT + - → Brightness Down
󰽶 SUPER + ALT + N → Night Light Toggle
󰅶 SUPER + ALT + C → Caffeine Toggle
󰒲 SUPER + ALT + O → System Suspend
󰁍 SUPER + ←/→/↑/↓ → Move Focus
󰁍 SUPER + H/J/K/L → Move Focus (Vim)
󰜸 SUPER + SHIFT + ←/→/↑/↓ → Move Window
󰜸 SUPER + SHIFT + H/J/K/L → Move Window (Vim)
󰩨 SUPER + CTRL + ←/→/↑/↓ → Resize Window
󰩨 SUPER + CTRL + H/J/K/L → Resize Window (Vim)
󰌾 ALT + L → Lock Screen
󰑓 SUPER + SHIFT + T → Restart Panel
󰖕 SUPER + T → Hide Panel
󰸉 SUPER + ALT + W → Wallpaper Selector
󰍉 CTRL + SHIFT + ESC → System Monitor
󱂬 SUPER + 1-9/0 → Switch Workspace
󰜸 SUPER + SHIFT + 1-9/0 → Move to Workspace
󰜸 SUPER + ALT + 1-9/0 → Move Silent to Workspace
󱂩 SUPER + S → Toggle Special Workspace
󰜸 SUPER + SHIFT + S → Move to Special Workspace
󰍹 SUPER + ALT + [ → Move Workspace to Left Monitor
󰍹 SUPER + ALT + ] → Move Workspace to Right Monitor
󰍽 SUPER + SCROLL → Switch Workspace
󰍽 SHIFT + ALT + H/L → Previous/Next Workspace
󰍽 SHIFT + ALT + ←/→ → Previous/Next Workspace
󰆧 SUPER + LMB Drag → Move Window
󰩨 SUPER + RMB Drag → Resize Window
󰹑 PRINT → Screenshot Area (Clipboard)
󰹑 SUPER + PRINT → Screenshot Area (Save)
󰹑 SUPER + ALT + P → Screenshot Full Screen
󰕾 XF86AudioRaiseVolume → Volume Up
󰕿 XF86AudioLowerVolume → Volume Down
󰖁 XF86AudioMute → Toggle Mute
󰍬 XF86AudioMicMute → Toggle Mic Mute
󰃞 XF86MonBrightnessUp → Brightness Up
󰃝 XF86MonBrightnessDown → Brightness Down
󰒭 XF86AudioNext → Next Track
󰐊 XF86AudioPlay → Play/Pause
󰒮 XF86AudioPrev → Previous Track
󰐎 SUPER + F10 → OBS Recording Toggle
EOF
}

# Kanata Keymaps
show_kanata_keymaps() {
    cat << EOF
󰌌 Kanata Home Row Mods
A → Tap: a | Hold: Left Ctrl
S → Tap: s | Hold: Left Alt
D → Tap: d | Hold: Left Meta
F → Tap: f | Hold: Left Shift
J → Tap: j | Hold: Right Shift
K → Tap: k | Hold: Right Meta
L → Tap: l | Hold: Right Alt
; → Tap: ; | Hold: Right Ctrl

󰌌 Kanata Layers
V → Tap: v | Hold: Fast Mouse Layer
B → Tap: b | Hold: Mouse Layer (slow)
X → Tap: x | Hold: Mouse Scroll Layer
Space → Tap: Space | Hold: Vim Navigation Layer

󰅒 Vim Navigation (Space Layer)
H → Left | J → Down | K → Up | L → Right

󰍽 Mouse Navigation
V Hold → Fast mouse movement + L/R click
B Hold → Slow mouse movement + L/R click
X Hold → Scroll Up/Down
EOF
}

# Function to show category-based view
show_categories() {
    CATEGORY=$(echo -e "󰍉 All Keybindings\n󰌌 Kanata Keybindings\n󰇘 Window Management\n󱂬 Workspaces\n󰝚 Media Controls\n󰕾 System Controls\n󰹑 Screenshots\n󰍉 Applications" | rofi -dmenu -i -p "Keymap Categories")
    
    case "$CATEGORY" in
        *"All Keybindings")
            show_keymaps | rofi -dmenu -i -p "Keybindings" -no-custom
            ;;
        *"Window Management")
            show_keymaps | grep -E "(Move Focus|Move Window|Resize|Close|Float|Split|Fullscreen|Pin|Drag)" | rofi -dmenu -i -p "Window Management" -no-custom
            ;;
        *"Kanata"*)
            show_kanata_keymaps | rofi -dmenu -i -p "Kanata Keys" -no-custom
            ;;
        *"Workspaces")
            show_keymaps | grep -E "(Workspace|Special)" | rofi -dmenu -i -p "Workspace Keys" -no-custom
            ;;
        *"Media Controls")
            show_keymaps | grep -E "(Media|Play|Pause|Track|Music|Volume|Brightness)" | rofi -dmenu -i -p "Media Controls" -no-custom
            ;;
        *"System Controls")
            show_keymaps | grep -E "(Power|Lock|Exit|Suspend|Mute|Night Light|Caffeine|System)" | rofi -dmenu -i -p "System Controls" -no-custom
            ;;
        *"Screenshots")
            show_keymaps | grep -E "(Screenshot|PRINT)" | rofi -dmenu -i -p "Screenshot Keys" -no-custom
            ;;
        *"Applications")
            show_keymaps | grep -E "(Terminal|Browser|File Manager|Rofi|Emoji|Clipboard|KeePass|OBS)" | rofi -dmenu -i -p "Application Keys" -no-custom
            ;;
    esac
}

# Main logic - directly show categories
show_categories
