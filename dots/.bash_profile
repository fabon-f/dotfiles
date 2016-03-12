#!/usr/bin/env bash

[ -r "$HOME/.profile" -a -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -r "$HOME/.bashrc" -a -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

if ! echo $PATH | tr ':' '\n' | grep "^/usr/local/bin$" > /dev/null; then
    export PATH="/usr/local/bin:$PATH"
fi

export PATH="/usr/local/sbin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo "rbenv not found"; fi

if which nodebrew > /dev/null; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH;
else
    echo "nodebrew not found";
fi


[ -d "$HOME/.exenv/bin" ] && export PATH="$HOME/.exenv/bin:$PATH"

if which exenv > /dev/null; then
    eval "$(exenv init -)"
else
    echo "exenv not found"
fi
