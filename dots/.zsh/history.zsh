history-all() {
    history -n 1
}

available () {
    local cmd
    local candidates=($(echo $1 | tr ':' ' '))
    for cmd in $candidates; do
        if type "$cmd" >/dev/null 2>&1; then
            echo $cmd
            return 0
        fi
    done
    return 1
}

select-history() {
    local tac
    if which tac > /dev/null 2>&1; then
        tac='tac'
    elif echo 'hoge' | tail -r >/dev/null 2>&1; then
        tac='tail -r'
    else
        tac="awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'"
    fi

    local original_buffer=$BUFFER
    local original_cursor=$CURSOR

    local filtering_tool
    if ! filtering_tool=$(available 'fzf:peco'); then
        exit 1
    fi

    local result
    case "$filtering_tool" in
        fzf ) result=$(history-all | fzf --query "$LBUFFER" --tac) ;;
        peco ) result=$(history-all | eval $tac | peco --query "$LBUFFER") ;;
    esac
    if [[ $? = 0 ]]; then
        BUFFER=$result
        CURSOR=${#BUFFER}
    else
        BUFFER=$original_buffer
        CURSOR=$original_cursor
    fi

    zle reset-prompt
}

if available "fzf:peco" > /dev/null; then
    zle -N select-history
    bindkey '^R' select-history
fi
