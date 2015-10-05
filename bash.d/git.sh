# Git setup and miscellaney

function git_setup() {
    if [[ ! -z ${df_git_email} ]] && [[ ! -z ${df_git_user} ]]; then
        if ! grep -q 'email' ${HOME}/.gitconfig; then
            git config --global user.email ${df_git_email}
        fi
        if ! grep -q 'name' ${HOME}/.gitconfig; then
            git config --global user.name "${df_git_user}"
        fi

    fi
}

git_setup
