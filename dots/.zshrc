#!/usr/bin/env zsh

# bindkey -e

if which direnv > /dev/null; then eval "$(direnv hook zsh)"; else echo "missing direnv"; fi

alias irb="pry"
alias direnv="EDITOR=vim direnv"

if [ -r "$HOME/.enhancd/init.sh" -a -f "$HOME/.enhancd/init.sh" ]; then
    source "$HOME/.enhancd/init.sh"
else
    echo "missing enhancd"
fi

if [ -r "$HOME/.zshrc_own" -a -f "$HOME/.zshrc_own" ]; then
    source "$HOME/.zshrc_own"
fi
if [ -r "$HOME/.zshenv_own" -a -f "$HOME/.zshenv_own" ]; then
    source "$HOME/.zshenv_own"
fi

[ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)
[ -d "$HOME/.asdf/completions" ] && fpath=("$HOME/.asdf/completions" $fpath)
[ -d "$HOME/.zsh/completions" ] && fpath=("$HOME/.zsh/completions" $fpath)
autoload -U compinit
compinit -u

PROMPT="%F{cyan}%~ $%f "

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob
setopt IGNOREEOF

# from http://qiita.com/b4b4r07/items/9e1bbffb1be70b6ce033
available () {
    local x candidates
    candidates="$1:"
    while [ -n "$candidates" ]
    do
        x=${candidates%%:*}
        candidates=${candidates#*:}
        if type "$x" >/dev/null 2>&1; then
            echo "$x"
            return 0
        else
            continue
        fi
    done
    return 1
}

function select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    local original_buffer=$BUFFER
    local original_cursor=$CURSOR
    local result

    local filtering_tool;
    if ! filtering_tool=$(available "fzf:peco"); then
        exit 1
    fi

    if [ $filtering_tool = "fzf" ]; then
        result=$(history -n 1 | fzf --query "$LBUFFER" --tac)
    elif [ $filtering_tool = "peco" ]; then
        result=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
    fi

    if [ "$result" != "" ]; then
        BUFFER=$result
        CURSOR=$#BUFFER
    else
        BUFFER=$original_buffer
        CURSOR=$original_cursor
    fi
    zle redisplay
}

if which apm > /dev/null; then
    apm-install-sync() {
        echo "$@" | tr " " "\n" | grep -v '^-' | xargs -I {} sh -c "apm install --production {} && apm star {}"
    }
    apm-uninstall-sync() {
        echo "$@" | tr " " "\n" | grep -v '^-' | xargs -I {} sh -c "apm uninstall {} && apm unstar {}"
    }
fi

if available "fzf:peco" > /dev/null; then
    zle -N select-history
    bindkey '^R' select-history
fi
