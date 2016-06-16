#!/bin/sh

set -eu

FORMULAS=`brew list`
ALREADY_INSTALLED=1

for FORMULA in bash bash-completion coreutils curl direnv erlang fzf findutils gibo git nodebrew peco rbenv tree wget zsh zsh-completions vim tig
do
    if ! echo $FORMULAS | tr " " "\n" | grep "^$FORMULA$" > /dev/null; then
        echo "$FORMULA not found"
        brew install $FORMULA
        $ALREADY_INSTALLED=0
    fi
done

[ $ALREADY_INSTALLED -eq 1 ] && echo "All formulas are already installed"
