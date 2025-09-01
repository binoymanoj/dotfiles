#!/usr/bin/env bash

# Archlinux Installed Package Removing Script
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj
#
# added alias in zshrc configuration (alias pkgdel)

# By running this script you'll prompt with a fzf picker with all the installed packages on your system (both Pacman & AUR) select the package to remove and hit enter

set -euo pipefail

# Check dependencies
command -v fzf >/dev/null 2>&1 || { echo "Error: fzf not installed."; exit 1; }

# Prepare combined list of installed packages
mapfile -t PACKAGES < <(
  echo "# pacman installed packages"
  pacman -Qq |
    sed 's/^/pacman: /'
  echo "# yay installed packages"
  yay -Qq |
    sed 's/^/yay: /'
)

# Launch fzf
selected=$(printf '%s\n' "${PACKAGES[@]}" |
  fzf --multi --ansi --border \
      --header "Select packages to remove (spaces to multi-select; ENTER to confirm)" \
      --preview 'case {1} in
                   pacman:*) pkg="${{1#pacman: }}"; pacman -Qi "$pkg";;
                   yay:*) pkg="${{1#yay: }}"; yay -Qi "$pkg";;
                 esac' \
      --bind 'ctrl-a:select-all,ctrl-d:deselect-all,ctrl-s:toggle-sort' \
)

# If no selection, exit
[ -z "$selected" ] && { echo "No packages selected."; exit 0; }

# Confirm deletion
echo "Selected packages for removal:"
printf '%s\n' "$selected"
read -rp "Proceed with removal? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

# Delete selected packages
while IFS= read -r line; do
  type=${line%%:*}
  pkg=${line#*: }
  if [[ $type == "pacman" ]]; then
    sudo pacman -Rns "$pkg"
  else
    yay -Rns "$pkg"
  fi
done <<< "$selected"
