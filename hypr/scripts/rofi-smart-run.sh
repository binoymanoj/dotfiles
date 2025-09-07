#!/bin/bash

# Rofi Smart Run Script (open url in browser with rofi - keymap in hyprland.conf - MainMod+r)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Usage: 
# - Normal search: "linux tutorial" → DuckDuckGo (default)  
# - Google search: "linux tutorial :g" → Google
# - DuckDuckGo search: "linux tutorial :d" → DuckDuckGo

input="$1"
browser="brave"  # or brave, chromium, etc.

if [[ "$input" =~ ^https?:// ]]; then
    $browser "$input" &
elif [[ "$input" =~ \.[a-zA-Z]{2,}(/|$) ]]; then 
    # if search params contains .com or .in or any extension to it, it'll directly open as link instead of searching it as word
    $browser "https://$input" &
elif [[ "$input" =~ ^localhost:[0-9]+(/.*)?$ ]]; then
    # if search params contains localhost,  it'll directly open as link instead of searching it as word
    $browser "http://$input" &
elif command -v "$input" &> /dev/null; then
    "$input" &
else
    # Check for search engine suffix
    if [[ "$input" == *" :g" ]]; then
        # Google search - remove the :g suffix
        search_term="${input% :g}"
        query=$(echo "$search_term" | sed 's/ /+/g')
        $browser "https://www.google.com/search?q=$query" &
    elif [[ "$input" == *" :d" ]]; then
        # DuckDuckGo search - remove the :d suffix
        search_term="${input% :d}"
        query=$(echo "$search_term" | sed 's/ /+/g')
        $browser "https://www.duckduckgo.com/?q=$query" &
    else
        # Default to DuckDuckGo
        query=$(echo "$input" | sed 's/ /+/g')
        $browser "https://www.duckduckgo.com/?q=$query" &
    fi
fi
