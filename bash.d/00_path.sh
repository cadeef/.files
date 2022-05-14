# shellcheck shell=bash

# We do a bit of extra work by appending over and over again
# but it makes it considerably easier to toggle/reorder them on the fly.

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Add `~/.local/bin` because it's a thing
export PATH="$HOME/.local/bin:$PATH"

# Add `.files/bin` to the `$PATH`
export PATH="$HOME/.files/bin:$PATH"

# Add rust tools
export PATH="$HOME/.cargo/bin:$PATH"

if [ "$OSFAMILY" == 'Darwin' ]; then
    # Brew support
    export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
fi

if [ "$OSFAMILY" == 'Linux' ]; then
    # Brew support
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
