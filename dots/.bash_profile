# shellcheck shell=bash

# Used in sourced files
OSFAMILY=$(uname)
export OSFAMILY

# Load config if it is readable
# shellcheck disable=SC1090
[[ -r ${HOME}/.files/config ]] && source "${HOME}/.files/config"

# Load bash options, should error if unsupported
# * Case-insensitive globbing (used in pathname expansion)
# * Append to the Bash history file, rather than overwriting it
# * Autocorrect typos in path names when using `cd`
# * Autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt
# * Enable extended globbing, e.g. ${HOME}/.ssh"/*+(_rsa|_dsa)
for option in {nocaseglob,histappend,cdspell,autocd,globstar,extglob}; do
    shopt -s "${option}"
done
unset option

# Load bash.d:
for file in "${HOME}/.files/bash.d"/*.sh; do
    # shellcheck disable=SC1090
    [[ -r ${file} ]] && source "${file}"
done
unset file
