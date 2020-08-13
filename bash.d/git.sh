# shellcheck shell=bash

# Git setup and miscellaney

git_setup() {
    # $df_* are loaded by sourcing ${HOME}/.files/config in .bash_profile
    # shellcheck disable=SC2154
    if [[ -n ${df_git_email} && -n ${df_git_user} ]]; then
        if ! grep -q 'email' "${HOME}/.gitconfig"; then
            git config --global user.email "${df_git_email}"
        fi
        if ! grep -q 'name' "${HOME}/.gitconfig"; then
            git config --global user.name "${df_git_user}"
        fi

    fi
}

git_setup
