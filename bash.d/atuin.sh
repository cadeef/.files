# shellcheck shell=bash

# Initialize atuin
eval "$(atuin init bash)"

# Fire starship
eval "$(starship init bash)"

function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
# shellcheck disable=SC2034
starship_precmd_user_func="set_win_title"
