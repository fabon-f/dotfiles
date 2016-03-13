#!/usr/bin/env zsh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo "rbenv not found"; fi
if which exenv > /dev/null; then eval "$(exenv init -)"; else echo "exenv not found"; fi

if which direnv > /dev/null; then eval "$(direnv hook zsh)"; else echo "missing direnv"; fi

alias irb="pry"

if [ -r "$HOME/.enhancd/enhancd.sh" -a -f "$HOME/.enhancd/enhancd.sh" ]; then
    source "$HOME/.enhancd/enhancd.sh"
else
    echo "missing enhancd"
fi

[ -e /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

PROMPT="%F{cyan}%~ $%f "

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
