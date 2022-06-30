#!/usr/bin/env bash

if type brew &>/dev/null; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
    then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
            [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
    fi
fi

if which direnv > /dev/null; then eval "$(direnv hook bash)"; else echo "missing direnv"; fi

PS1="\[\e[1;32m\]\w \$\[\e[00m\] "

if type starship &>/dev/null; then
    eval "$(starship init bash)"
fi

if [ -r "$HOME/.enhancd/enhancd.sh" -a -f "$HOME/.enhancd/enhancd.sh" ]; then
    source "$HOME/.enhancd/enhancd.sh"
else
    echo "missing enhancd"
fi
