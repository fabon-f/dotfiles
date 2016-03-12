#!/usr/bin/env bash

if which brew > /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

if which direnv > /dev/null; then eval "$(direnv hook bash)"; else echo "missing direnv"; fi

alias irb="pry"

PS1="\[\e[1;32m\]\w \$\[\e[00m\] "

if [ -r "$HOME/.enhancd/enhancd.sh" -a -f "$HOME/.enhancd/enhancd.sh" ]; then
    source "$HOME/.enhancd/enhancd.sh"
else
    echo "missing enhancd"
fi
