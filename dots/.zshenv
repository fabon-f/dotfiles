#!/usr/bin/env zsh
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

export EDITOR=vim

if which nodebrew > /dev/null 2>&1 || [ -d "$HOME/.nodebrew" ]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH;
fi

if ! which rbenv > /dev/null 2>&1 && [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "/Library/TeX/texbin" ] && export PATH="/Library/TeX/texbin:$PATH"
[ -d "/usr/local/texlive/bin" ] && export PATH="/usr/local/texlive/bin:$PATH"

export FZF_DEFAULT_OPTS="--extended --cycle --reverse --select-1 --exit-0 --ansi"
which fd > /dev/null 2>&1 && export FZF_DEFAULT_COMMAND="fd --type f -HIL -E .git -E .DS_Store -E '*.swp'"

setopt no_global_rcs

if [ -r "$HOME/.zshenv_own" -a -f "$HOME/.zshenv_own" ]; then
    source "$HOME/.zshenv_own"
fi
