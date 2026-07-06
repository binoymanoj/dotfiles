#!/usr/bin/env bash
# tmux-scratch-popup.sh - Disposable scratch note in tmux popup
# Opens same /tmp note file every time until manually cleared

NOTE_FILE="/tmp/tmux-scratch.md"

touch "$NOTE_FILE"

nvim "$NOTE_FILE"
