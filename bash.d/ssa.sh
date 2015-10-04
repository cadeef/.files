# ssa - ssh-add wrapper

function ssa {
    if [ $# -eq 0 ]; then
        ssh-add -l
    else
        if [ -r ${HOME}/.ssh/${1} ]; then
            ssh-add ${HOME}/.ssh/${1}
        else
            ssh-add ${@}
        fi
    fi
}

# Tab completion - display private keys
[ -d ${HOME}/.ssh/ ] && complete -o "default" -W "$(ls ${HOME}/.ssh | grep -E '(rsa|dsa)$')" ssa
