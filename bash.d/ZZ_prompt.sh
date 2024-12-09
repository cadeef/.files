# shellcheck shell=bash

# Load iterm shell integration (it uses PROMPT for tracking)
if [[ -f "${HOME}/.iterm2_shell_integration.bash" ]]; then
    # shellcheck disable=SC1091
    source "${HOME}/.iterm2_shell_integration.bash"
fi

# Initialize atuin
eval "$(atuin init bash)"

# Fire direnv
eval "$(direnv hook bash)"

# Fire starship
eval "$(starship init bash)"

function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
# shellcheck disable=SC2034
starship_precmd_user_func="set_win_title"
