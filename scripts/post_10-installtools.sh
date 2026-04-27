#!/usr/bin/env bash

# Install miscellaneous tools

set -euo pipefail

# Setup Brew if it isn't installed
if ! hash brew &>/dev/null; then
    echo "Installing brew..."
    # Not safe, blah blah blah
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install terminal-specific tools
brew bundle install --file "${HOME}/.Brewfiles/.Brewfile.terminal"

# MacOS-specific
if [[ $(uname) == 'Darwin' ]]; then
    brew bundle install --file "${HOME}/.Brewfiles/.Brewfile.dev"

    # Install virtualbox if for some reason we are on a non-arm system
    if [[ $(uname -p) != "arm" ]]; then
        brew install --cask virtualbox
    fi
fi

# Install Python-based tools with uv
uv_tools=(cade-task sqlite-utils pyinstrument)

if hash uv &>/dev/null; then
    for tool in "${uv_tools[@]}"; do
        uv tool install --upgrade "${tool}"
    done
else
    echo "WARNING: uv not found, tools not installed: ${uv_tools[*]} "
fi
