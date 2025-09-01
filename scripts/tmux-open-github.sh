#!/usr/bin/env bash

# Open current repo's github in browser
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

dir=$(tmux run "echo #{pane_start_path}")
cd "$dir"

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not in a git repository"
    exit 1
fi

url=$(git remote get-url origin 2>/dev/null)

if [[ -z "$url" ]]; then
    echo "No remote origin found"
    exit 1
fi

if [[ $url == git@github.com:* ]]; then
    # Convert git@github.com:user/repo.git to https://github.com/user/repo
    repo_path=$(echo "$url" | sed 's/git@github.com://' | sed 's/\.git$//')
    browser_url="https://github.com/$repo_path"
elif [[ $url == *"github.com"* ]]; then
    # Already HTTPS format, remove .git if present
    browser_url=$(echo "$url" | sed 's/\.git$//')
else
    echo "This repository is not hosted on GitHub"
    echo "Remote URL: $url"
    exit 1
fi

echo "Opening: $browser_url"
brave "$browser_url"         # open in brave browser
