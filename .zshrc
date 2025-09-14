##############################################################
######################### ZSH CONFIG #########################
##############################################################
# @binoy_manoj                   https://github.com/binoymanoj



###################################
############## ZINIT ##############
###################################

# Zinit Plugin Manager Initializing
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# # Previous Method (now it's handled with zinit above)
# # Install and load syntax highlighting
# if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#     source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#     typeset -A ZSH_HIGHLIGHT_STYLES
#     ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
#     ZSH_HIGHLIGHT_STYLES[alias]='fg=075'
#     ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=075'
#     ZSH_HIGHLIGHT_STYLES[global-alias]='fg=075'
#     ZSH_HIGHLIGHT_STYLES[function]='fg=075'
#     ZSH_HIGHLIGHT_STYLES[command]='fg=075'
#     ZSH_HIGHLIGHT_STYLES[builtin]='fg=075'
#     ZSH_HIGHLIGHT_STYLES[path]='fg=111'
# fi
#
# # Install and load autosuggestions (this provides history-based suggestions)
# if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
#     source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#     # Configure autosuggestion color and strategy
#     ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
#     ZSH_AUTOSUGGEST_STRATEGY=(history completion)
#     ZSH_AUTOSUGGEST_USE_ASYNC=1
#     bindkey '^ ' autosuggest-accept  # Ctrl+Space to accept suggestion
#     bindkey '^f' autosuggest-accept  # Ctrl+f to accept suggestion
# fi


# No Idea what is the following line for, it was there in my config so kept it as it is. maybe useful in future
# ## [Completion]
# ## Completion scripts setup. Remove the following line to uninstall
# [[ -f ~/.dart-cli-completion/zsh-config.zsh ]] && . ~/.dart-cli-completion/zsh-config.zsh || true
# ## [/Completion]


#####################################
############## HISTORY ##############
#####################################

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory          # Append history 
setopt sharehistory           # Share history between all sessions
setopt hist_ignore_space      # Won't save in history when we leave a space before command (helpful for not saving credentials)
setopt hist_ignore_all_dups   # Don't record duplicates
setopt hist_ignore_dups       # Remove older duplicate entries
setopt hist_save_no_dups      # Don't record duplicates
setopt hist_find_no_dups      # No duplicates when searching
setopt hist_expire_dups_first # Expire duplicate entries first
setopt hist_reduce_blanks     # Remove superfluous blanks
setopt hist_verify            # Don't execute immediately upon history expansion
setopt inc_append_history     # Add commands to history as they are typed
setopt extended_history       # Add timestamps to history


# Directory Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# From previous configuration, keeping it just in case
# # History search configuration
# autoload -U history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
#
# # Better history search keybindings
# bindkey '^[[A' history-beginning-search-backward-end    # Up arrow
# bindkey '^[[B' history-beginning-search-forward-end     # Down arrow
# bindkey '^P' history-beginning-search-backward-end      # Ctrl+P
# bindkey '^N' history-beginning-search-forward-end       # Ctrl+N
# bindkey '^R' history-incremental-search-backward        # Ctrl+R for history search
# bindkey '^S' history-incremental-search-forward         # Ctrl+S for forward history search

##############################################
############## AUTO COMPLETIONS ##############
##############################################

# Load auto-completions
autoload -U compinit && compinit

# Advanced completion settings
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' completer _oldlist _expand _complete _match _prefix _history
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:corrections' format ' %F{075}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{075}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{075}-- %d --%f'
zstyle ':completion:*:warnings' format ' %F{075}-- no matches found --%f'
zstyle ':completion:*' format ' %F{075}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias ls='ls --color'


######################################
############## VIM MODE ##############
######################################

bindkey -v            # Enables Vim mode
export KEYTIMEOUT=1


#########################################
############## KEYBINDINGS ##############
#########################################

# Keybindings for History
bindkey '^p' history-search-backward    # Search backwards in history using CTRL + p  (eg. curl then CTRL + P)
bindkey '^n' history-search-forward     # Search forwards in history using CTRL + n

# Additional key bindings for better completion
bindkey '^[[Z' reverse-menu-complete  # Shift-Tab to reverse completion menu
bindkey '^I' complete-word            # Tab to complete
bindkey '^y' autosuggest-accept       # Ctrl+Y to accept suggestion

############################################
############## SHELL PACKAGES ##############
############################################

# FZF Shell Integration
eval "$(fzf --zsh)"

# ZOXIDE for better cd
eval "$(zoxide init zsh)"

##########################################
############## SHELL CONFIG ##############
##########################################

# Prompt Configuration
autoload -Uz promptinit && promptinit
autoload -Uz vcs_info
precmd() { vcs_info }

# GO path
export GOPATH=$HOME/go 
# Enhanced Path
export PATH=$PATH:$HOME/bin:/usr/local/bin:$GOPATH/bin:$HOME/.config/emacs/bin/

# Change cursor shape based on mode
function zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne "\e[2 q" ;;  # Block cursor (normal mode)
    viins|main) echo -ne "\e[6 q" ;;  # Line cursor (insert mode)
  esac
}
zle -N zle-keymap-select

# Initialize cursor on line editor start
function zle-line-init {
    echo -ne "\e[6 q"  # Line cursor for insert mode
}
zle -N zle-line-init

# Also force cursor update when prompt is shown
function precmd() {
    vcs_info
    # auto_fetch_on_first_visit      # git pull & push info
    echo -ne "\e[6 q"  # Ensure line cursor when prompt appears
}

bindkey '^H' backward-kill-word

# Better command line editing
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Aliases with softer colored output
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'

# Load colors
autoload -U colors && colors

# Softer directory colors
export LS_COLORS="di=38;5;111:ln=38;5;075:so=38;5;075:pi=38;5;075:ex=38;5;075:bd=38;5;075:cd=38;5;075:su=38;5;075:sg=38;5;075:tw=38;5;075:ow=38;5;075"

# Configure git info in prompt
zstyle ':vcs_info:git:*' formats '%F{242} (%b)%f'
# zstyle ':vcs_info:git*' formats '%b'            # git pull & push info
# zstyle ':vcs_info:git*' actionformats '%b|%a'   # git pull & push info

# Function to get git status with push/pull counts      # git pull & push info
# function git_prompt_info() {
#     if git rev-parse --git-dir > /dev/null 2>&1; then
#         local branch=$(git branch --show-current 2>/dev/null)
#         local git_status=""
#
#         # Get ahead/behind counts
#         local ahead_behind=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
#         if [[ -n "$ahead_behind" ]]; then
#             local ahead=$(echo $ahead_behind | cut -f1)
#             local behind=$(echo $ahead_behind | cut -f2)
#
#             # Add arrows with counts using the same colors as your theme
#             [[ $ahead -gt 0 ]] && git_status+=" %F{242}↑$ahead%f"
#             [[ $behind -gt 0 ]] && git_status+=" %F{242}↓$behind%f"
#         fi
#
#         # Output the complete git info (removed the * and + indicators for cleaner look)
#         if [[ -n "$branch" ]]; then
#             echo "%F{242} ($branch$git_status)%f"
#         fi
#     fi
# }


# Track visited git repos in this session
# typeset -A visited_git_repos              # git pull & push info

# Auto-fetch on first visit to a git repo    # git pull & push info 
# function auto_fetch_on_first_visit() {
#     if git rev-parse --git-dir > /dev/null 2>&1; then
#         local git_root=$(git rev-parse --show-toplevel 2>/dev/null)
#
#         # If we haven't visited this repo in this session
#         if [[ -n "$git_root" ]] && [[ -z "${visited_git_repos[$git_root]}" ]]; then
#             visited_git_repos[$git_root]=1
#             {
#                 git fetch &>/dev/null
#             } &!
#         fi
#     fi
# }

# SHELL Prompt
setopt PROMPT_SUBST
# PROMPT='%F{075}%n%f%F{242}@%f%F{075}%m%f%F{242}:%f%F{111}%~%f${vcs_info_msg_0_} %F{242}❯%f '    # cyph3r@archlinux:~ ❯
# PROMPT='%F{242}❯%f '      # ❯
#
# ~/Codes (master)
# ❯
# PROMPT='%F{183}%~%f$(git_prompt_info)    # git pull & push info    # ~/Codes (master ↑2 ↓1)
PROMPT='%F{183}%~%f${vcs_info_msg_0_}       
%F{211}❯%f '    


####################################
############## CUSTOM ##############
####################################

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PNPM Setup
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# PNPM End

#####################################
############## EXPORTS ##############
#####################################

export EDITOR=nvim

#####################################
############## ALIASES ##############
#####################################

alias cd="z"             # replacing cd with z (zoxide) for jumping to location from history
alias ff="fastfetch"     # ff for fastfetch
alias vi="nvim"          # vi for neovim
alias zta="zathura"      # zta for zathura PDF viewer
alias open="xdg-open"    # xdg-open with open

# Git Aliases
alias g='git'
alias gf='git fetch'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias gss='git status --short'
alias gst='git status -sb'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias greset='git reset'
alias gclean='git clean -fd'
alias gcl='git clone'

# Pacman Aliases
alias paci='sudo pacman -S --noconfirm'           # Install a package
alias pacr='sudo pacman -Rns'                     # Remove a package along with unused dependencies
alias pacu='sudo pacman -Syu --noconfirm'         # Update system
alias pacs='pacman -Ss'                           # Search for a package
alias pacl='pacman -Qe'                           # List installed packages
alias pacorph='pacman -Qdt'                       # List explicitly installed packages not required as dependencies
alias pacclean='sudo pacman -Rns $(pacman -Qdtq)' # Remove orphaned packages
alias paccleanall='sudo paccache -r'              # Clear package cache (keeping the last 3 versions)
alias paccleanfull='sudo paccache -r -k0'         # Full cache clean (dangerous, deletes all)
alias paciinfo='pacman -Si'                       # Show package info
alias pacinfo='pacman -Qi'                        # Show info of an installed package

# Yay Aliases
alias yayi='yay -S --noconfirm'                   # Install a package from AUR or repo
alias yayr='yay -Rns'                             # Remove a package
alias yayu='yay -Syu --noconfirm'                 # Update all packages (official + AUR)
alias yays='yay -Ss'                              # Search for a package in AUR and repos
alias yayinfo='yay -Si'                           # Show info about a package
alias yayclean='yay -Yc'                          # Remove orphaned packages
alias yayedit='yay -S --editmenu --nodiffmenu'    # Edit PKGBUILD before installing (interactive)
alias yayoutdated='yay -Qua'                      # Check for outdated AUR packages

# Pacman & Yay package removing script
alias pkgdel='~/.config/scripts/remove-pkg.sh'

# Task warrior Aliases (comment the following Aliases out if you're not using it)
alias t='task'
alias ta='task add'
alias tc='task context'

# YT DLP Aliases (comment the following Aliases out if you're not using it)
alias ytdlp='yt-dlp'
alias ytdlpmp3='yt-dlp -x --audio-format mp3'

# POSTING API Client Aliases (comment the following Aliases out if you're not using it)
alias posting='cd "$(find ~/Codes/api-collection -mindepth 1 -maxdepth 1 -type d ! -name '.git' | fzf)" && posting --collection ./ --env ./.env'   # this script list all the directories inside ~/Codes/api-collection in a fuzzy finder and by selecting the dir you want it opens in POSTING TUI


# Run Tmux on terminal open (commented out for now, sometimes it gets annoying. It opens default session on every terminal opened. Might need in the future)
# if command -v tmux &> /dev/null; then
#   if [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
#     tmux attach -t default || tmux new -s default
#   fi
# fi

#########################################
############## END OF FILE ##############
#########################################
