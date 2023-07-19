# shellcheck shell=bash

# Git setup and miscellaney

git_setup() {
    # $df_* are loaded by sourcing ${HOME}/.files/config in .bash_profile
    # shellcheck disable=SC2154
    if [[ -n ${df_git_email-} ]] && ! git config --global user.email &>/dev/null; then
        git config --global user.email "${df_git_email}"
    fi
    if [[ -n ${df_git_user-} ]] && ! git config --global user.name &>/dev/null; then
        git config --global user.name "${df_git_user}"
    fi
}

git_setup
