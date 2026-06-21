#!/usr/bin/env zsh
#
# create_folders.zsh
# ----------------------------------------------------------------------------
# This script sets up the folder structure for your dotfiles repository and
# creates minimal default "dotfiles" if they don't already exist.
#
# Usage:
#   chmod +x create_folders.zsh
#   ./create_folders.zsh
#
# ----------------------------------------------------------------------------
# Directory Structure:
#
# dotfiles/
# ├── config
# │   ├── git
# │   │   ├── ignore     (global gitignore)
# │   │   └── config     (optional global .gitconfig or partial config)
# │   ├── starship.toml  (example for starship prompt)
# │   └── other-tool     (e.g. other CLI tool config)
# ├── zsh
# │   ├── macos
# │   │   ├── .zshrc
# │   │   └── .zprofile
# │   ├── linux
# │   │   ├── .zshrc
# │   │   └── .zprofile
# │   └── oh-my-posh.json
# ├── windows
# │   ├── bootstrap_windows.ps1
# │   └── (optional) profile.ps1
# ├── scripts
# │   ├── bootstrap_mac.zsh
# │   ├── bootstrap_linux.zsh
# ├── .devcontainer
# │   ├── devcontainer.json
# │   └── Dockerfile
# ├── install.zsh
# ├── install.ps1
# ├── bootstrap.zsh
# ├── README.md
# └── .gitignore
#
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Fail immediately on error, and treat unset variables as an error
# ----------------------------------------------------------------------------
set -euo pipefail

echo "Creating folder structure for your repo..."

# ----------------------------------------------------------------------------
# Determine Script Directory
# ----------------------------------------------------------------------------
SCRIPT_DIR="$( cd "$( dirname "${(%):-%x}" )" && pwd )"

# ----------------------------------------------------------------------------
# Create Folders
# ----------------------------------------------------------------------------

# Root-level directories
mkdir -p "$SCRIPT_DIR/zsh"
mkdir -p "$SCRIPT_DIR/windows"
mkdir -p "$SCRIPT_DIR/config"
mkdir -p "$SCRIPT_DIR/scripts"
mkdir -p "$SCRIPT_DIR/.devcontainer"

# Subdirectories for ZSH
mkdir -p "$SCRIPT_DIR/zsh/macos"
mkdir -p "$SCRIPT_DIR/zsh/linux"

# Optional directories for additional configs/tools
mkdir -p "$SCRIPT_DIR/config/git"
mkdir -p "$SCRIPT_DIR/config/other-tool"

# Optional directories if you use these technologies
mkdir -p "$SCRIPT_DIR/vscode"
mkdir -p "$SCRIPT_DIR/ruby"
mkdir -p "$SCRIPT_DIR/psql"

# ----------------------------------------------------------------------------
# Summary
# ----------------------------------------------------------------------------
echo "Folder structure set up successfully!"
exit 0
