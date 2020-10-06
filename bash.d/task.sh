# shellcheck shell=bash

task_add_list() {
    echo "not quite supported"
    return 1
}

task_list() {
    local list
    list=${1:-$(pretty_code_name)}

    if [[ -z ${list} || ${list} == "all" ]]; then
        reminders show-lists
    else
        reminders show "${list}"
    fi
}

task_complete() {
    local list
    list="$(pretty_code_name)"

    if [[ -z ${list} ]]; then
        echo "Couldn't figure out which list to work with"
    else
        reminders complete "${list}" "${1}"
    fi
}

# Add task to Reminders.app
# Usage: `task_add 'foo'` or `echo 'foo' | task_add`
task_add() {
    if is_in_path "reminders"; then
        local text
        if [[ -t 0 ]]; then
            text="${1}" # argument
        else
            text=$(cat) # pipe
        fi

        local project
        project=$(pretty_code_name)
        local add_command="reminders add ${project} ${text}"

        # A cheap try/catch
        local output
        output=$(${add_command})

        if [[ ${output} =~ ^No\ reminders\ list\ matching ]]; then
            # List doesn't exist, create it
            task_add_list "${project}" &&
                eval "${add_command}"
        else
            echo "${output}"
        fi

    else
        echo "Can't find reminders-cli, maybe you need to install it?"
        echo "Reference: https://github.com/keith/reminders-cli"
    fi
}

# Make it convenient to type
alias t='task_list'
alias ta='task_add'
alias tc='task_complete'
