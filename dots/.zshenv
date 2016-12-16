#!/usr/bin/env zsh
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

if which nodebrew > /dev/null 2>&1 || [ -d "$HOME/.nodebrew" ]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH;
else
    echo "nodebrew not found";
fi

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.asdf/bin" ] && export PATH="$HOME/.asdf/bin:$PATH"
[ -d "$HOME/.asdf/shims" ] && export PATH="$HOME/.asdf/shims:$PATH"
[ -d "/Library/TeX/texbin" ] && export PATH="/Library/TeX/texbin:$PATH"

export FZF_DEFAULT_OPTS="--extended --cycle --reverse --select-1 --exit-0 --ansi"
setopt no_global_rcs

if [ -r "$HOME/.zshenv_own" -a -f "$HOME/.zshenv_own" ]; then
    source "$HOME/.zshenv_own"
fi
