#!/usr/bin/env bash

# Install miscellaneous tools

set -euo pipefail

# Setup Brew if it isn't installed
if ! hash brew &> /dev/null; then
    echo "Installing brew..."
    # Not safe, blah blah blah
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# MacOS-specific
if [[ $(uname) == 'Darwin' ]]; then
    # Get that brew action going to install/upgrade from ~/.Brewfile
    brew bundle install --global
fi
