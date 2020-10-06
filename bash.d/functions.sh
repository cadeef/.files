# shellcheck shell=bash

# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@" || echo "Failed to cd"
}

# All the dig info
digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# Add note to Notes.app (OS X 10.8)
# Usage: `note 'title' 'body'` or `echo 'body' | note`
# Title is optional
note() {
    local title
    local body
    if [ -t 0 ]; then
        title="$1"
        body="$2"
    else
        title=$(cat)
    fi
    osascript > /dev/null << EOF
tell application "Notes"
    tell account "iCloud"
        tell folder "Notes"
            make new note with properties {name:"$title", body:"$title" & "<br><br>" & "$body"}
        end tell
    end tell
end tell
EOF
}

# Manually remove a downloaded app or file from the quarantine
unquarantine() {
    for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine; do
        xattr -r -d "$attribute" "$@"
    done
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
s() {
    if [[ $# -eq 0 ]]; then
        subl .
    else
        subl "$@"
    fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
    if [ $# -eq 0 ]; then
        vim .
    else
        vim "$@"
    fi
}

# `o` with no arguments opens current directory, otherwise opens the given
# location
o() {
    if [[ $# -eq 0 ]]; then
        open .
    else
        open "$@"
    fi
}

# Arbitrary window titles
title() {
    if [[ -z $1 ]]; then
        printf "\033]0;%s\007" "$(hostname)"
    else
        printf "\033]0;%s\007" "$1"
    fi
}

# ssk - remove line from ~/.ssh/known_hosts
ssk() {
    local host=${1}
    ssh-keygen -R "${host}"
}
