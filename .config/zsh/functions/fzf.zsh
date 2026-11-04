# best fzf aliases ever
_fuzzy_edit_search_file_content() {
    # [f]uzzy [e]dit  [s]earch [f]ile [c]ontent
    local selected_file
    local fzf_options=()
    local preview_cmd
    if command -v "bat" &>/dev/null; then
        preview_cmd=('bat --color always --style=plain --paging=never {}')
    else
        preview_cmd=('cat {}')
    fi
    fzf_options+=(--height "80%" --layout=reverse --cycle --preview-window right:60% --preview ${preview_cmd[@]})
    selected_file=$(grep -irl "${1:-}" ./ | fzf "${fzf_options[@]}")

    if [[ -n "$selected_file" ]]; then
        if command -v "$EDITOR" &>/dev/null; then
            "$EDITOR" "$selected_file"
        else
            echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
            vim "$selected_file"
        fi

    else
        echo "No file selected or search returned no results."
    fi
}

_fuzzy_man() {
    MAN="man"
    if [ -n "$1" ]; then
        $MAN "$@"
        return $?
    else
        $MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
        return $?
    fi
}


alias ffec='_fuzzy_edit_search_file_content' \
    fman='_fuzzy_man' \
    fp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --print0 | xargs -0 -r -o nvim'
