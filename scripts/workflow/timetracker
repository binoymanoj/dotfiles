#!/bin/bash
CATEGORIES=("Personal" "Reading" "Learning" "Coding" "CTF" "Work" "Meeting" "Exercise" "Walking" "Chess" "Wasting Time" "Sleep" "Break" "Stop Tracking")
SELECTED=$(printf '%s\n' "${CATEGORIES[@]}" | rofi -dmenu -p "Track time:" -i)

if [ -z "$SELECTED" ]; then exit 0; fi

if [ "$SELECTED" == "Stop Tracking" ]; then
    timew stop 2>/dev/null
    notify-send "⏱️ Time Tracker" "Stopped tracking" -t 3000
    pkill -SIGUSR1 ags 2>/dev/null || true
    exit 0
fi

timew stop 2>/dev/null
timew start "$SELECTED"
notify-send "⏱️ Time Tracker" "Started tracking: $SELECTED" -t 3000
pkill -SIGUSR1 ags 2>/dev/null || true
