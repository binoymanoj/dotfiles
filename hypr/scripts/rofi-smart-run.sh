#!/bin/bash

# Rofi Smart Run Script (open url in browser with rofi - keymap in hyprland.conf - MainMod+r)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# Usage: 
# - Normal search: "linux tutorial" → DuckDuckGo (default)  
# - Google search: "linux tutorial :g" → Google
# - DuckDuckGo search: "linux tutorial :d" → DuckDuckGo

browser="brave"   # change to firefox, chromium, etc.

# Build a small menu: tokens are shown as selectable items.
menu=$'!g\n!d\n!y\n'    # rofi will show these; user may type any other input as well

# If argument provided, use it; otherwise show rofi with menu entries + hint message
if [ -n "$1" ]; then
  input="$*"
else
  if ! command -v rofi >/dev/null 2>&1; then
    echo "rofi required but not found" >&2
    exit 1
  fi

  # Show menu items and let user freely type or select an item.
  # -i case-insensitive, -p prompt, -mesg shows instructions above.
  input="$(printf '%s\n' "$menu" | rofi -dmenu -i -p "Search or URL:" \
    -mesg "Hints: !g → Google | !d → DuckDuckGo (default) | !y → YouTube")"
fi

# Trim leading/trailing whitespace
input="$(echo -e "$input" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

# Exit if empty (user cancelled)
[ -z "$input" ] && exit 0

# Helper to open URL in background cleanly
open_in_browser() {
  url="$1"
  # use setsid so it detaches from rofi; redirect output to /dev/null
  setsid "$browser" "$url" >/dev/null 2>&1 &
  disown
}

# If it's an explicit URL starting with http/https
if [[ "$input" =~ ^https?:// ]]; then
  open_in_browser "$input"
  exit 0
fi

# If input is a single token with no spaces and looks like a hostname (e.g. example.com or example.co.uk)
# (only treat as URL when there are no spaces)
if [[ "$input" =~ ^[^[:space:]]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
  open_in_browser "https://$input"
  exit 0
fi

# If it's localhost:PORT or localhost:PORT/path
if [[ "$input" =~ ^localhost:[0-9]+(/.*)?$ ]]; then
  open_in_browser "http://$input"
  exit 0
fi

# If it is a single token executable (no spaces) and found in PATH, run it
if [[ "$input" != *" "* ]] && command -v "$input" >/dev/null 2>&1; then
  "$input" & disown
  exit 0
fi

# Token detection anywhere in the input: capture first occurrence of !g, !d, or !y
token=""
if [[ "$input" =~ (![gdy]) ]]; then
  token="${BASH_REMATCH[1]}"   # will be like "!g", "!d" or "!y"
fi

# If user selected a token alone (exact match), prompt for search term
if [[ "$input" == "!g" || "$input" == "!d" || "$input" == "!y" ]]; then
  # Prompt using rofi for the search term
  term="$(rofi -dmenu -p "Search (${input}):")"
  term="$(echo -e "$term" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  [ -z "$term" ] && exit 0
  input="$term $input"   # append token so the logic below handles it uniformly
  token="$input"         # ensure token still present; will be extracted below
fi

# If token exists in input, remove it and perform the chosen engine search
if [ -n "$token" ]; then
  # Remove the token from the input and trim whitespace
  search_term="$(echo "${input//$token/}" | xargs)"
  # If after removal search_term is empty, prompt
  if [ -z "$search_term" ]; then
    search_term="$(rofi -dmenu -p "Search (${token}):")"
    search_term="$(echo -e "$search_term" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    [ -z "$search_term" ] && exit 0
  fi
  # Replace spaces with + for a simple query (if you want full encoding, see note)
  q="$(echo "$search_term" | sed 's/ /+/g')"

  case "$token" in
    "!g")
      open_in_browser "https://www.google.com/search?q=$q"
      ;;
    "!d")
      open_in_browser "https://www.duckduckgo.com/?q=$q"
      ;;
    "!y")
      open_in_browser "https://www.youtube.com/results?search_query=$q"
      ;;
  esac
  exit 0
fi

# No token present: fallback default search (DuckDuckGo)
q="$(echo "$input" | sed 's/ /+/g')"
open_in_browser "https://www.duckduckgo.com/?q=$q"
exit 0
