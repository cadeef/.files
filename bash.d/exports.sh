# shellcheck shell=bash

# Make vim the default editor
export EDITOR='vim'

# Enlightened paths for cd
export CDPATH=".:$HOME:$CDPATH"

# Larger bash history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Turn on timestamps for bash history
export HISTTIMEFORMAT="%F %T "
# Make some commands not show up in history
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:ll'

# Prefer US English and use UTF-8
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Shamlessly taken from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Use bat if installed, otherwise less
if hash bat &> /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    export MANPAGER='less -X'
fi

# Handle ansi color gracefully is less
export LESS='-R'

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

# Help Docker find itself
# export DOCKER_HOST='tcp://0.0.0.0:2375'

export GOPATH=${HOME}/go

# Convenience
export c_code=${HOME}/code
