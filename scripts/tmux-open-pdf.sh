#!/usr/bin/env bash

# Open PDFs script
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

if [[ $# -eq 1 ]]; then
    selected=$1
else
    dir=$(tmux run "echo #{pane_start_path}")
    selected=$(find $dir ~/CyberSec/Books ~/Documents/Books ~/Development/Books -mindepth 1 -maxdepth 1 -name "*.pdf" | \
        sed "s|^$HOME/||" | \
        fzf \
            --height=100% \
            --layout=reverse \
            --border=rounded \
            --prompt="📚 " \
            --pointer="→" \
            --header="Select PDF to open" \
            --preview="pdfinfo $HOME/{} 2>/dev/null || echo 'PDF info not available'" \
            --preview-window=right:45%:border-left \
            --color=fg:#cad3f5,hl:#ed8796,fg+:#cad3f5,hl+:#ed8796 \
            --color=border:#8087a2,header:#8087a2,prompt:#c6a0f6 \
            --color=pointer:#f4dbd6,marker:#f4dbd6,info:#c6a0f6 \
            --info=inline
    )
    # add the following line inside fzf config above to get the consistent color matching or remove it use the default fzf bg color
    # --color=bg:#1A1D23 \

    # Add home path back
    if [[ -n "$selected" ]]; then
        selected="$HOME/$selected"
    fi
fi

if [[ -z "$selected" ]]; then
    exit 1
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
tmux new-window -n "$selected_name" -d zathura "$selected"
tmux select-window -l

