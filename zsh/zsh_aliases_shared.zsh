#!/usr/bin/env zsh
#
# zsh_aliases_shared.zsh
#
# Common aliases that apply to ALL OSes (macOS, Linux, etc.)

###############################################################################
# SAFER FILE OPERATIONS
###############################################################################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

###############################################################################
# DIRECTORY NAVIGATION SHORTCUTS
###############################################################################
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd -'
alias c='clear'

###############################################################################
# SYSTEM MONITORING & NETWORKING (common)
###############################################################################
alias ping='ping -c 5'
alias myip='curl ifconfig.me'

###############################################################################
# GIT SHORTCUTS
###############################################################################
alias gst='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glo='git log --oneline --graph --decorate'

###############################################################################
# DEVELOPMENT SHORTCUTS
###############################################################################
alias v='nvim'
alias code='code .'
alias py='python3'
alias ipy='ipython'

###############################################################################
# RAILS SHORTCUTS
###############################################################################
alias r='rails'
alias be='bundle exec'

echo "Loaded shared aliases."
