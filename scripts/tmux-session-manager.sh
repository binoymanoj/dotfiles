#!/usr/bin/env bash
# tmux-session-manager.sh - Interactive tmux session manager
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

show_help() {
    echo "Keybindings:"
    echo "  Enter   - Switch to selected session"
    echo "  Ctrl+a  - Create new session"
    echo "  Ctrl+r  - Rename selected session"
    echo "  Ctrl+x  - Kill selected session"
    echo "  ?       - Show this help"
    echo ""
    echo "Navigation:"
    echo "  ↑/↓      - Move selection"
    echo "  Ctrl+j/k - Move selection"
    echo "  Esc/q    - Quit"
}

get_session_info() {
    local session="$1"
    echo "Session: $session"
    echo "────────────────────────────────"
    
    # Get session info with windows and their current directories
    local windows_info=$(tmux list-windows -t "$session" -F "#{window_index}:#{window_name} [#{pane_current_path}]" 2>/dev/null | \
        sed 's|'$HOME'|~|g')
    
    if [[ -n "$windows_info" ]]; then
        echo "$windows_info" | while IFS= read -r line; do
            echo "  $line"
        done
    else
        echo "  No windows found"
    fi
    
    echo ""
    echo "Window count: $(tmux list-windows -t "$session" 2>/dev/null | wc -l)"
}

get_sessions_list() {
    # Get all sessions with their creation time and window count
    tmux list-sessions -F "#{session_name} (#{session_windows} windows) - #{session_created}" 2>/dev/null | \
        sort
}

create_new_session() {
    # Use tmux-sessionizer for directory selection to create new session
    ~/.config/scripts/tmux-sessionizer.sh new
}

rename_session() {
    local session="$1"
    echo -n "Enter new name for session '$session': "
    read -r new_name
    if [[ -n "$new_name" ]]; then
        tmux rename-session -t "$session" "$new_name" 2>/dev/null
        if [[ $? -eq 0 ]]; then
            echo "Session renamed to '$new_name'"
        else
            echo "Failed to rename session"
        fi
        sleep 1
    fi
}

kill_session() {
    local session="$1"
    echo -n "Kill session '$session'? [y/N]: "
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        tmux kill-session -t "$session" 2>/dev/null
        if [[ $? -eq 0 ]]; then
            echo "Session '$session' killed"
        else
            echo "Failed to kill session"
        fi
        sleep 1
    fi
}

main_loop() {
    while true; do
        clear
        echo "=== TMUX SESSION MANAGER ==="
        echo ""
        
        # Check if tmux is running
        if ! pgrep tmux >/dev/null 2>&1; then
            echo "No tmux sessions found."
            echo ""
            echo "Press 'ctrl-a' to create new session, 'q' to quit"
            read -n 1 -s key
            case "$key" in
                $'\x01') create_new_session ;;  # Ctrl+a
                q|$'\e') exit 0 ;;
            esac
            continue
        fi

        # Get current session if we're inside tmux
        current_session=""
        if [[ -n "$TMUX" ]]; then
            current_session=$(tmux display-message -p '#S')
        fi

        # Use fzf to select session with preview
        selected_session=$(get_sessions_list | \
            fzf \
                --height=100% \
                --layout=reverse \
                --border=rounded \
                --prompt="🖥️  " \
                --pointer="→" \
                --header="Sessions | Enter:switch ctrl-a:new-session ctrl-r:rename ctrl-x:kill ?:help" \
                --header-lines=0 \
                --preview="~/.config/scripts/tmux-session-manager.sh preview {1}" \
                --preview-window=right:50%:border-left:wrap \
                --color=fg:#cad3f5,hl:#ed8796,fg+:#cad3f5,hl+:#ed8796 \
                --color=border:#8087a2,header:#8087a2,prompt:#c6a0f6 \
                --color=pointer:#f4dbd6,marker:#f4dbd6,info:#c6a0f6 \
                --info=inline \
                --bind="ctrl-a:execute(~/.config/scripts/tmux-session-manager.sh new-session)+reload(~/.config/scripts/tmux-session-manager.sh list)" \
                --bind="ctrl-r:execute(~/.config/scripts/tmux-session-manager.sh rename {1})+reload(~/.config/scripts/tmux-session-manager.sh list)" \
                --bind="ctrl-x:execute(~/.config/scripts/tmux-session-manager.sh kill {1})+reload(~/.config/scripts/tmux-session-manager.sh list)" \
                --bind="?:execute(~/.config/scripts/tmux-session-manager.sh help)" \
                --expect=ctrl-c,esc,q
        )
        # add the following line inside fzf config above to get the consistent color matching or remove it use the default fzf bg color
        # --color=bg:#1A1D23 \

        # Handle the result
        local exit_code=$?
        local key_pressed=$(echo "$selected_session" | head -1)
        local selection=$(echo "$selected_session" | tail -1)

        if [[ $exit_code -ne 0 ]] || [[ "$key_pressed" == "ctrl-c" ]] || [[ "$key_pressed" == "esc" ]] || [[ "$key_pressed" == "q" ]]; then
            exit 0
        fi

        if [[ -n "$selection" ]]; then
            session_name=$(echo "$selection" | awk '{print $1}')
            
            # Switch to the selected session
            if [[ -n "$TMUX" ]]; then
                tmux switch-client -t "$session_name"
            else
                tmux attach-session -t "$session_name"
            fi
            exit 0
        fi
    done
}

# Handle script arguments for sub-commands
case "$1" in
    "preview")
        get_session_info "$2"
        ;;
    "list")
        get_sessions_list
        ;;
    "rename")
        rename_session "$2"
        ;;
    "kill")
        kill_session "$2"
        ;;
    "new-session")
        create_new_session
        ;;
    "help")
        show_help
        read -n 1 -s
        ;;
    *)
        main_loop
        ;;
esac
