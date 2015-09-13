
function git_setup() {
    if [ ! -f ${df_state_dir}/git_configured ]; then
        if [ ! -f ${df_state_dir}/git_conf_nag ]; then
            if which -s git; then
                if ! (grep -q user.name ${HOME}/.gitconfig && grep -q user.email ${HOME}/.gitconfig); then

                    if [[ -z ${df_git_user} ]] || [[ -z ${df_git_email} ]]; then
                        read -p 'Setup git commit user? [y|n]: ' -n 1 setup_resp

                        if [[ ${setup_resp} =~ ^[Yy]$ ]]; then
                            echo
                            read -p 'Git name (user.name): ' df_git_user_tmp
                            read -p 'Git email (user.email): ' df_git_email_tmp

                            git config --global user.name "${df_git_user_tmp}"
                            git config --global user.email ${df_git_email_tmp}
                            touch ${df_state_dir}/git_configured
                        else
                            touch ${df_state_dir}/git_conf_nag
                        fi
                    else
                        git config --global user.name "${df_git_user}"
                        git config --global user.email ${df_git_email}
                        touch ${df_state_dir}/git_configured
                    fi
                fi
            else
                if [ ! -f $df_state_dir/git_missing_nag ]; then
                    echo "MISSING: Git, you might miss it" && \
                    touch $df_state_dir/git_missing_nag
                fi
            fi
        fi
    fi
}

git_setup
