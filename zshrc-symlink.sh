#/bin/bash

# Symlink Script (by running this script your .zshrc will be symlinked from .config dir to ~/ directory. follow the instructions below)
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj
#
# Instructions:
# cd ~/.config
# chmod +x zshrc-symlink.sh
# ./zshrc-symlink.sh
#
# Instructions (if you already have a pretty good .zshrc configuration): 
# cp ~/.zshrc ~/.config
# cp ~/.zshrc ~/.zshrc.bkp
# cd ~/.config
# chmod +x zshrc-symlink.sh
# ./zshrc-symlink.sh
#
# NOTE: after running all this, validate if you have 2 ".zshrc" file one inside you .config directory and one in ~/ (home). The one in home is the copy of the once in .config 
# cd ~
# ls -la
# it should have something like this 
# .zshrc -> /home/cyph3r/.config/.zshrc


ln -s ~/.config/.zshrc ~/.zshrc
