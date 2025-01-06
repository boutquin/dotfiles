#!/usr/bin/env zsh
#
# install.zsh
#
# This script sets up symlinks for your dotfiles on both macOS and Linux.
# It:
#   1) Detects the OS (macOS or Linux).
#   2) Picks the correct Zsh config files (i.e., .zshrc, .zprofile) from the
#      appropriate folder in your dotfiles repo (e.g. zsh/macos or zsh/linux).
#   3) Symlinks private_env.zsh to ~/.config/private_env.zsh with secure
#      permissions if found.
#   4) Symlinks global Git config & ignore to ~/.config/git.
#   5) Symlinks starship and Oh My Posh config files.
#   6) Optionally symlinks your Ruby on Rails config.
#   7) NEW: Symlinks zsh_aliases_shared.zsh (if present) and an OS-specific
#      zsh_aliases.zsh (macOS or Linux).
#
# Usage:
#   1. cd into your dotfiles repo
#   2. Run this script: ./install.zsh
#
# Ensure the script is executable (chmod +x install.zsh) before running.
#
# Tip: If you'd like to see each command as it's run, set `set -x` (debug mode).
#

set -euo pipefail

###############################################################################
# Resolve DOTFILES_DIR to the directory that holds this script.
# This ensures we can run the script from anywhere.
###############################################################################
DOTFILES_DIR="$( cd "$( dirname "${(%):-%x}" )" && pwd )"

###############################################################################
# Function: backupFile
# Description:
#   Renames an existing file or symlink to a .bak-<timestamp> backup,
#   so that we don't lose the user's original config if it already exists.
# Arguments:
#   1) The full path to the file to back up
###############################################################################
backupFile() {
  local target_file="$1"

  if [ -e "$target_file" ] || [ -L "$target_file" ]; then
    local backup_name="${target_file}.bak-$(date +%Y%m%d%H%M%S)"
    echo "  Backing up '$target_file' to '$backup_name'"
    mv "$target_file" "$backup_name"
  fi
}

###############################################################################
# Function: createSymlink
# Description:
#   Backs up the target if it exists, then creates a symlink from source_file
#   to target_file. Also checks if the target is already a correct symlink
#   to avoid unnecessary backups in repeated runs.
# Arguments:
#   1) source_file - The absolute path to the source in $DOTFILES_DIR
#   2) target_file - The absolute path to the final location (e.g. $HOME/.zshrc)
###############################################################################
createSymlink() {
  local source_file="$1"
  local target_file="$2"

  if [ ! -e "$source_file" ]; then
    echo "  Warning: source '$source_file' does not exist; skipping."
    return
  fi

  if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
    echo "  Skipping: '$target_file' is already symlinked to '$source_file'."
    return
  fi

  backupFile "$target_file"
  echo "  Creating symlink: $target_file -> $source_file"
  ln -s "$source_file" "$target_file"
}

###############################################################################
# Secure private_env.zsh
# Description:
#   Sets restrictive permissions (chmod 600) on private_env.zsh if it exists,
#   ensuring no other users on the system can read it.
###############################################################################
securePrivateEnv() {
  local private_env_file="$1"

  if [ -e "$private_env_file" ]; then
    echo "  Securing private_env.zsh with restrictive permissions (chmod 600)."
    chmod 600 "$private_env_file"
  else
    echo "  Warning: '$private_env_file' not found. Skipping security step."
  fi
}

###############################################################################
# Detect OS (macOS or Linux). Adjust if you want more granular checks.
###############################################################################
OS_TYPE="$(uname -s)"
case "${OS_TYPE}" in
  Darwin*)   CURRENT_OS="macos";;
  Linux*)    CURRENT_OS="linux";;
  *)         CURRENT_OS="unknown";;
esac

echo "Detected OS: $CURRENT_OS"

if [[ "$CURRENT_OS" == "unknown" ]]; then
  echo "Error: Unsupported OS: $OS_TYPE. Exiting..."
  exit 1
fi

###############################################################################
# Symlink private_env.zsh to ~/.config/private_env.zsh
###############################################################################
echo ""
echo "Handling private_env.zsh..."
PRIVATE_ENV_SOURCE="$DOTFILES_DIR/private_env.zsh"
PRIVATE_ENV_TARGET="$HOME/.config/private_env.zsh"

# Ensure ~/.config directory exists
mkdir -p "$HOME/.config"

# Create symlink and secure the private_env.sh file
createSymlink "$PRIVATE_ENV_SOURCE" "$PRIVATE_ENV_TARGET"
securePrivateEnv "$PRIVATE_ENV_SOURCE"

###############################################################################
# Symlink Zsh configuration for the detected OS
###############################################################################
echo ""
echo "Symlinking Zsh configuration (.zshrc, .zprofile) for $CURRENT_OS..."
ZSH_SOURCE_DIR="$DOTFILES_DIR/zsh/$CURRENT_OS"

createSymlink "$ZSH_SOURCE_DIR/.zshrc" "$HOME/.zshrc"
createSymlink "$ZSH_SOURCE_DIR/.zprofile" "$HOME/.zprofile"

###############################################################################
# Symlink OS-specific aliases, plus a shared aliases file if present
###############################################################################
echo ""
echo "Symlinking Zsh alias files..."

# Shared aliases file (optional)
SHARED_ALIASES_SOURCE="$DOTFILES_DIR/zsh/zsh_aliases_shared.zsh"
SHARED_ALIASES_TARGET="$HOME/.config/zsh/zsh_aliases_shared.zsh"

# Ensure ~/.config directory exists
mkdir -p "$HOME/.config/zsh"

createSymlink "$SHARED_ALIASES_SOURCE" "$SHARED_ALIASES_TARGET"

# OS-specific aliases (e.g., zsh_aliases.zsh in zsh/macos or zsh/linux)
OS_SPECIFIC_ALIASES_SOURCE="$DOTFILES_DIR/zsh/$CURRENT_OS/zsh_aliases.zsh"
OS_SPECIFIC_ALIASES_TARGET="$HOME/.config/zsh/zsh_aliases.zsh"

createSymlink "$OS_SPECIFIC_ALIASES_SOURCE" "$OS_SPECIFIC_ALIASES_TARGET"

###############################################################################
# Symlink Oh My Posh configuration to ~/.oh-my-posh.json
###############################################################################
echo ""
echo "Symlinking Oh My Posh configuration..."
OH_MY_POSH_SOURCE="$DOTFILES_DIR/zsh/oh-my-posh.json"
OH_MY_POSH_TARGET="$HOME/.oh-my-posh.json"

createSymlink "$OH_MY_POSH_SOURCE" "$OH_MY_POSH_TARGET"

###############################################################################
# Symlink Git global config and ignore to ~/.config/git/
###############################################################################
echo ""
echo "Symlinking Git configuration files to XDG-compliant locations..."

# Ensure ~/.config/git directory exists
mkdir -p "$HOME/.config/git"

# Symlink Git configuration files
createSymlink "$DOTFILES_DIR/config/git/ignore" "$HOME/.config/git/ignore"
createSymlink "$DOTFILES_DIR/config/git/config" "$HOME/.config/git/config"

###############################################################################
# Symlink starship configuration (~/.config/starship.toml by default)
###############################################################################
echo ""
echo "Symlinking Starship prompt configuration (starship.toml)..."
createSymlink "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"

###############################################################################
# Symlink Ruby on Rails config to ~/.config/rails/
###############################################################################
echo ""
echo "Symlinking Ruby on Rails config..."
mkdir -p "$HOME/.config/rails"
createSymlink "$DOTFILES_DIR/config/rails/railsrc" "$HOME/.config/rails/railsrc"

###############################################################################
# Wrap up
###############################################################################
echo ""
echo "=========================================================="
echo "Done! Your dotfiles have been symlinked successfully."
echo "Detected OS: $CURRENT_OS"
echo "Please close and reopen your terminal, or run 'source ~/.zshrc' to load new configs."
echo "=========================================================="
