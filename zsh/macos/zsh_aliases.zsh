#!/usr/bin/env zsh
#
# zsh_aliases.zsh (macOS)
#
# This file contains alias definitions specific to macOS (Darwin).
# You can source this file directly from your .zshrc or .zprofile when on macOS.
#
# ============================= MACOS ALIASES ================================

###############################################################################
# FILE LISTING & MANAGEMENT (BSD tools)
###############################################################################
# 'ls' on macOS typically supports -G for color, -C for column format, etc.

alias l='ls -CFG'     # Show colors (-G), list entries in columns (-C).
alias ll='ls -laG'
alias la='ls -AG'
alias du='du -h -d 1' # Summarize disk usage (BSD variant accepts -d)

###############################################################################
# SYSTEM MONITORING
###############################################################################
# On macOS, 'free' is not installed by default. Consider using top, vm_stat, etc.
# alias free='top -l 1 | head -n 10'

###############################################################################
# MACOS-SPECIFIC COMMANDS
###############################################################################
# Commonly used macOS commands or shortcuts.

# alias o='open'     # Open files, directories, or URLs in the Finder
# alias diskutil='diskutil'  # Manage disk partitions

# If you'd like to override top with htop (if installed via brew):
# alias top='htop'

echo "Loaded macOS-specific aliases."
