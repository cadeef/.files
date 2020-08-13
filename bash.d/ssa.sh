# shellcheck shell=bash

# ssa - ssh-add wrapper

ssa() {
    if [[ $# -eq 0 ]]; then
        ssh-add -l
    elif [[ ${1} == '-d' ]]; then
        ssh-add -d "${HOME}/.ssh/${2}"
    else
        if [[ -r "${HOME}/.ssh/${1}" ]]; then
            ssh-add "${HOME}/.ssh/${1}"
        else
            ssh-add "${@}"
        fi
    fi
}

# Tab completion - display private keys
[ -d "${HOME}/.ssh/" ] && complete -o "default" -W "$(basename -a "${HOME}/.ssh"/*+(_rsa|_dsa))" ssa
