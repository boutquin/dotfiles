#!/usr/bin/env zsh
#
# ~/.zprofile (macOS)
#
# This file is executed for login shells. It is responsible for setting up
# environment variables and paths that should be available in all sessions
# (interactive, non-interactive, etc.) once logged in.
#
# ============================= Zsh Startup Files ==============================
#   1) ~/.zshenv   - Loaded for all shells (non-login, login, interactive)
#   2) ~/.zprofile - Loaded for login shells (environment variables/paths)
#   3) ~/.zlogin   - Loaded for login shells after ~/.zprofile
#   4) ~/.zshrc    - Loaded for interactive shells (aliases, functions, etc.)
#   5) ~/.zlogout  - Loaded at logout for login shells
# =============================================================================
#
# Because ~/.zprofile is primarily for login shells, it's the ideal place for:
#   - PATH modifications
#   - Long-running environment variables
#   - Sensitive environment variables (optional, if securely sourced)
#   - Non-interactive environment configs that must be present in all sessions
#
# For more details on Zsh startup files, see official Zsh documentation:
# https://zsh.sourceforge.net/Doc/Release/Files.html

###############################################################################
# Initialize Homebrew
###############################################################################
# On Apple Silicon Macs (M1, M2, etc.), Homebrew installs to /opt/homebrew.
# On Intel Macs, it installs to /usr/local. This command sets up the correct
# PATH, HOMEBREW_PREFIX, and related environment variables.
eval "$(/opt/homebrew/bin/brew shellenv)"

###############################################################################
# JetBrains Toolbox CLI
###############################################################################
# Added by JetBrains Toolbox App. Provides CLI access to JetBrains IDEs.
export PATH="$PATH:/Users/pierre/Library/Application Support/JetBrains/Toolbox/scripts"

###############################################################################
# Set XDG Base Directories
###############################################################################
# The XDG Base Directory specification helps reduce dotfile clutter in $HOME.
# By exporting these variables, many modern tools (e.g., Git, various CLIs)
# can store their configs/data/caches in the designated directories:
#   - XDG_CONFIG_HOME: Typically ~/.config
#   - XDG_CACHE_HOME:  Typically ~/.cache
#   - XDG_DATA_HOME:   Typically ~/.local/share
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

###############################################################################
# Load Private/Sensitive Environment Variables
###############################################################################
# If you have private environment variables (e.g., API keys, personal tokens),
# store them in a separate file (private_env.zsh) that is:
#   1) Not committed to version control
#   2) Securely permissioned (chmod 600)
#
# By sourcing them here, these variables become available to all sessions.
if [[ -f "$HOME/.config/private_env.zsh" ]]; then
    source "$HOME/.config/private_env.zsh"
else
    echo "Warning: $HOME/.config/private_env.zsh not found."
fi

###############################################################################
# Initialize rbenv (Ruby Version Manager) — OPTIONAL
###############################################################################
# Uncomment if using rbenv for managing Ruby versions. The '--no-rehash' flag
# avoids automatically running `rbenv rehash` on every command invocation,
# speeding up the shell. You can manually run `rbenv rehash` when you install
# a new Ruby version or gem with executables.
#
# eval "$(rbenv init - --no-rehash zsh)"

###############################################################################
# Final Instructions
###############################################################################
# Since this file is only read by login shells, you may need to explicitly
# start a new login shell to see changes. For instance:
#
#   exec zsh -l
#
# Or log out and log back in if you want to test changes in a more
# "fresh" environment.

[[ -n "$DEBUG_DOTFILES" ]] && echo "Loaded .zprofile (macOS)."

true  # Ensure sourcing this file never leaves a non-zero exit code
