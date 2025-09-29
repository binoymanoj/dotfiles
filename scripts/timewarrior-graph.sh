#!/bin/bash

# Timewarrior Data Visualization Script
# Usage: timewarrior-graph.sh <json-file>

JSON_FILE="${1:-timew-data.json}"

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: File '$JSON_FILE' not found!"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq (macOS) or apt install jq (Linux)"
    exit 1
fi

# Colors for output
BOLD='\033[1m'
RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'

# Function to convert ISO 8601 UTC to epoch seconds
iso_to_epoch() {
    local iso_date=$1
    # Convert format: 20250929T043535Z to 2025-09-29 04:35:35 UTC
    local formatted=$(echo "$iso_date" | sed -E 's/([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2})Z/\1-\2-\3 \4:\5:\6/')
    
    # Parse as UTC and convert to epoch
    if date --version >/dev/null 2>&1; then
        # GNU date (Linux)
        TZ=UTC date -d "$formatted" +%s 2>/dev/null
    else
        # BSD date (macOS)
        TZ=UTC date -j -f "%Y-%m-%d %H:%M:%S" "$formatted" +%s 2>/dev/null
    fi
}

# Function to convert ISO 8601 UTC to local time string
iso_to_local_time() {
    local iso_date=$1
    local epoch=$(iso_to_epoch "$iso_date")
    
    if [ -z "$epoch" ]; then
        echo "N/A"
        return
    fi
    
    # Convert epoch to local time
    date -d "@$epoch" +"%H:%M:%S" 2>/dev/null || date -r "$epoch" +"%H:%M:%S" 2>/dev/null
}

# Function to convert seconds to human readable format
seconds_to_human() {
    local seconds=$1
    local hours=$((seconds / 3600))
    local mins=$(((seconds % 3600) / 60))
    local secs=$((seconds % 60))
    
    if [ $hours -gt 0 ]; then
        printf "%dh %dm %ds" $hours $mins $secs
    elif [ $mins -gt 0 ]; then
        printf "%dm %ds" $mins $secs
    else
        printf "%ds" $secs
    fi
}

# Parse JSON and calculate durations per tag
echo -e "\n${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}  Timewarrior Summary Report${RESET}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"

# Check if file is empty or has no entries
entry_count=$(jq 'length' "$JSON_FILE")
if [ "$entry_count" -eq 0 ]; then
    echo "No time entries found for this period."
    exit 0
fi

# Extract data and calculate totals (grouped by tag)
declare -A tag_seconds
declare -A tag_count
total_seconds=0

while IFS= read -r line; do
    start=$(echo "$line" | jq -r '.start')
    end=$(echo "$line" | jq -r '.end')
    tags=$(echo "$line" | jq -r '.tags[]')
    
    # Convert ISO 8601 to epoch seconds
    start_sec=$(iso_to_epoch "$start")
    end_sec=$(iso_to_epoch "$end")
    
    if [ -z "$start_sec" ] || [ -z "$end_sec" ]; then
        continue
    fi
    
    duration=$((end_sec - start_sec))
    total_seconds=$((total_seconds + duration))
    
    # Add to tag total
    tag_seconds["$tags"]=$((${tag_seconds["$tags"]:-0} + duration))
    tag_count["$tags"]=$((${tag_count["$tags"]:-0} + 1))
done < <(jq -c '.[]' "$JSON_FILE")

# Check if we have any valid data
if [ $total_seconds -eq 0 ]; then
    echo "No valid time entries found (total duration is 0)."
    exit 0
fi

# Sort tags by duration (descending)
sorted_tags=$(for tag in "${!tag_seconds[@]}"; do
    echo "${tag_seconds[$tag]} $tag"
done | sort -rn)

# Find max duration for scaling bars
max_duration=$(echo "$sorted_tags" | head -1 | awk '{print $1}')
bar_width=40

echo -e "${BOLD}Tag Summary (Grouped):${RESET}\n"

# Color array for different tags
colors=("$GREEN" "$YELLOW" "$BLUE" "$MAGENTA" "$CYAN")
color_idx=0

while read -r duration tag; do
    percentage=$((duration * 100 / total_seconds))
    bar_length=$((duration * bar_width / max_duration))
    
    # Handle case where bar_length is 0
    if [ $bar_length -eq 0 ]; then
        bar_length=1
    fi
    
    # Select color
    color=${colors[$color_idx]}
    color_idx=$(((color_idx + 1) % ${#colors[@]}))
    
    # Create bar
    bar=$(printf "%-${bar_length}s" | tr ' ' '#')
    
    # Get count for this tag
    count=${tag_count["$tag"]}
    
    # Print tag info with count
    printf "${BOLD}%-15s${RESET} ${color}%-40s${RESET} %s (%d%%) [%d entries]\n" \
        "$tag" "$bar" "$(seconds_to_human $duration)" "$percentage" "$count"
    
done <<< "$sorted_tags"

# Print total
echo -e "\n${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}Total Time:${RESET}     $(seconds_to_human $total_seconds)"
echo -e "${BOLD}Total Entries:${RESET}  $entry_count"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"

# Detailed breakdown by tag
echo -e "${BOLD}Detailed Entries by Tag:${RESET}\n"

while read -r duration tag; do
    echo -e "${BOLD}${GREEN}${tag}:${RESET}"
    printf "  %-5s %-12s %-12s %-10s\n" "ID" "START" "END" "DURATION"
    echo "  ───────────────────────────────────────────────"
    
    jq -c --arg tag "$tag" '.[] | select(.tags[] == $tag)' "$JSON_FILE" | while IFS= read -r line; do
        id=$(echo "$line" | jq -r '.id')
        start=$(echo "$line" | jq -r '.start')
        end=$(echo "$line" | jq -r '.end')
        
        start_sec=$(iso_to_epoch "$start")
        end_sec=$(iso_to_epoch "$end")
        
        if [ -z "$start_sec" ] || [ -z "$end_sec" ]; then
            continue
        fi
        
        duration=$((end_sec - start_sec))
        
        start_time=$(iso_to_local_time "$start")
        end_time=$(iso_to_local_time "$end")
        
        printf "  %-5s %-12s %-12s %-10s\n" "$id" "$start_time" "$end_time" "$(seconds_to_human $duration)"
    done
    
    # Print subtotal for this tag
    tag_total=${tag_seconds["$tag"]}
    echo -e "  ${BOLD}Subtotal:${RESET} $(seconds_to_human $tag_total)\n"
done <<< "$sorted_tags"
