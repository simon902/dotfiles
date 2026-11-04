if command -v "bat" &>/dev/null; then
    alias cat='bat --style=plain --paging=never --color auto'
    # global alias: everytime "--help" occurs expand it to the alias
    alias -g -- --help='--help 2>&1 | bat --language=help --style=plain --paging=never --color auto'
fi
