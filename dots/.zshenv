#!/usr/bin/env zsh
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

if which nodebrew > /dev/null; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH;
else
    echo "nodebrew not found";
fi

[ -d "$HOME/.exenv/bin" ] && export PATH="$HOME/.exenv/bin:$PATH"

export FZF_DEFAULT_OPTS="--extended --cycle --reverse --select-1 --exit-0 --ansi"