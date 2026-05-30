#!/usr/bin/env bash
# tmux-quicknote-popup.sh - Quick note popup for tmux
# Opens neovim in a tmux popup with auto-incrementing note files

NOTES_DIR="$HOME/Notes/01 Inbox/Quicknotes"

# Create notes directory if it doesn't exist
mkdir -p "$NOTES_DIR"

# Get the next index number
get_next_index() {
    local last_index=0
    
    # Find all existing note files and extract the highest index
    if ls "$NOTES_DIR"/*.md >/dev/null 2>&1; then
        last_index=$(ls "$NOTES_DIR"/*.md 2>/dev/null | \
            grep -oP '\d+(?=-)' | \
            sort -n | \
            tail -1)
    fi
    
    # If no files found, start at 1, otherwise increment
    if [[ -z "$last_index" ]]; then
        echo 1
    else
        echo $((last_index + 1))
    fi
}

# Generate filename with index and date
generate_filename() {
    local index=$(get_next_index)
    local date=$(date +%Y-%m-%d)
    echo "${index}-${date}.md"
}

# Main execution
main() {
    local filename=$(generate_filename)
    local filepath="$NOTES_DIR/$filename"
    
    # Open neovim with the new note file
    nvim "$filepath"
}

main "$@"
