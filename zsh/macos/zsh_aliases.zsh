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

###############################################################################
# SUDOKU RESEARCH TOOLS (SukakuExplainer.Net local debugging oracles)
###############################################################################
# Personal local-use tools for cross-checking SukakuExplainer.Net behaviour.
# Built outside the project repo at ~/Developer/_tools/. Never wired into our
# build graph or CI — see ~/Developer/SukakuExplainer.Net/CLAUDE.local.md.

# Numeristiq (MAGREMENT/Numeristiq, CC-BY-NC-SA-4.0; private dev use only).
# Targets net9.0; DOTNET_ROLL_FORWARD lets it run on the .NET 10 runtime.
# Usage:
#   nq                                     # help
#   nq Sudoku Solve "<grid>" -p            # solve with path
#   nq Sudoku Backdoor "<grid>" --strategy-set ssts
#   nq Sudoku StrategyList
alias nq='DOTNET_ROLL_FORWARD=LatestMajor dotnet $HOME/Developer/_tools/numeristiq/ConsoleApplication/bin/Release/net9.0/ConsoleApplication.dll'

# kyoyama-kazusa Sudoku (kyoyama-kazusa/Sudoku, MIT; private dev use).
# Targets net11.0; .NET 11 SDK pinned via global.json in the clone.
# Built from SHA cbbb1ade with a thin local CLI host at sudoku-kyoyama-kazusa-host/.
# Adds a `rate <grid>` verb that bypasses the upstream AnalysisResult.ToString()
# formatter (which crashes on some grids) and emits {er, ep, ed, …} JSON instead.
# Usage:
#   kk                                     # help
#   kk rate "<grid>"                       # JSON: er/ep/ed/total/solved/step_count
#   kk analyze "<grid>"                    # upstream pretty trace (may crash)
#   kk solve "<grid>" -m bitwise           # solve (bitwise|dlx|backtracking)
#   kk find -t JuniorExocet "<grid>"       # find next instance of a technique
#   kk generate hard --technique JuniorExocet --count 10
alias kk='dotnet $HOME/Developer/_tools/sudoku-kyoyama-kazusa-host/bin/Release/net11.0/kk.dll'

[[ -n "$DEBUG_DOTFILES" ]] && echo "Loaded macOS aliases."

true  # Ensure sourcing this file never leaves a non-zero exit code
