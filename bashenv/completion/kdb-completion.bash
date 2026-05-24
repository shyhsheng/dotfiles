_kdb_completion() {
    local cur prev cmd db_dir tools
    COMPREPLY=()

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd="${COMP_WORDS[1]}"
    db_dir="${KDB_DIR:-$HOME/.config/dotfiles/docs/keymaps}"

    tools="$(
        find "$db_dir" -maxdepth 1 -name '*.md' -printf '%f\n' 2>/dev/null \
            | sed 's/\.md$//'
    )"

    case "$COMP_CWORD" in
        1)
            COMPREPLY=( $(compgen -W "list open find add help -h --help" -- "$cur") )
            ;;
        2)
            case "$cmd" in
                open|add)
                    COMPREPLY=( $(compgen -W "$tools" -- "$cur") )
                    ;;
                find)
                    COMPREPLY=()
                    ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _kdb_completion kdb
