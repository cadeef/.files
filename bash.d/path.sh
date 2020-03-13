# shellcheck shell=bash

# We do a bit of extra work by appending over and over again
# but it makes it considerably easier to toggle/reorder them on the fly.

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Add `.files/bin` to the `$PATH`
export PATH="$HOME/.files/bin:$PATH"

# Add rust tools
export PATH="$HOME/.cargo/bin:$PATH"

# Add go bin support
export PATH="$HOME/go/bin:$PATH"

if [ "$OSFAMILY" == 'Darwin' ]; then
    # Brew support
    export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
fi
