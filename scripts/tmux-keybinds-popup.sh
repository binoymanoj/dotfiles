#!/usr/bin/env bash
# tmux-keybinds-popup.sh - Cheatsheet of tmux keybinds in a popup

cat <<'EOF' | less -R
TMUX KEYBINDS (prefix = C-b)

 General
  prefix r        Reload config
  prefix R        Rename session
  prefix I        Install plugins (TPM)

 Panes
  prefix |        Split pane horizontally
  prefix \        Split pane vertically
  prefix h/j/k/l  Resize pane (repeatable)
  prefix m        Maximize/zoom current pane

 Windows
  M-0..9          Switch to window 0-9 (no prefix)

 Copy mode (vi keys)
  prefix [        Enter copy mode
  v               Begin selection
  y               Copy selection (+ system clipboard)
  r               Toggle rectangle selection

 Utilities (popups)
  prefix g        Open GitHub repo of current project
  prefix f        Sessionizer (current session)
  prefix F        Sessionizer (new session)
  prefix H        Sessionizer: home (new window)
  prefix o        Open PDF picker
  prefix s        Session manager
  prefix k        Quicknote (new numbered note file)
  prefix C-d      Scratch note (disposable, /tmp, same file till cleared)
  prefix C-e      File manager (nnn)
  prefix C-g      Git TUI (lazygit, current pane path)
  prefix C-c      Music player (rmpc)
  prefix C-z      Quick edit ~/.zshrc
  prefix C-t      Terminal in current pane path (zsh)
  prefix C-h      This keybinds menu
  prefix C-m      System monitor (btop)

  q               Quit this menu
EOF
