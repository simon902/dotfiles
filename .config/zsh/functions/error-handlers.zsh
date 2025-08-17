function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf "${green}zsh${reset}: command ${purple}NOT${reset} found: ${bright}'%s'${reset}\n" "$1"


    printf "${bright}Searching for packages that provide '${bright}%s${green}'...\n${reset}" "${1}"

    if ! yay -F -- "/usr/bin/$1"; then
        printf "${bright}${green}[ ${1} ]${reset} ${purple}NOT${reset} found in the system and no package provides it.\n"
    else
        printf "${green}[ ${1} ] ${reset} might be provided by the above packages.\n"
    fi

    return 127
}

# Unused for now!!!!
function no_such_file_or_directory_handler {
    local red='\e[1;31m' reset='\e[0m'
    printf "${red}zsh: no such file or directory: %s${reset}\n" "$1"
    return 127
}
