#!/usr/bin/env bash

if [ -f /opt/homebrew/bin/brew -a -x /opt/homebrew/bin/brew -a -z "$HOMEBREW_PREFIX" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[ -r "$HOME/.profile" -a -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -r "$HOME/.bashrc" -a -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

if ! echo $PATH | tr ':' '\n' | grep "^/usr/local/bin$" > /dev/null; then
    export PATH="/usr/local/bin:$PATH"
fi

export PATH="/usr/local/sbin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo "rbenv not found"; fi
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
