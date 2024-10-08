export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

export EDITOR=vim

if [ -f /opt/homebrew/bin/brew -a -x /opt/homebrew/bin/brew -a -z "$HOMEBREW_PREFIX" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
[ -d "/opt/homebrew/opt/curl/bin" ] && export PATH="/opt/homebrew/opt/curl/bin:$PATH"

if ! which rbenv > /dev/null 2>&1 && [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "/Library/TeX/texbin" ] && export PATH="/Library/TeX/texbin:$PATH"
[ -d "/usr/local/texlive/bin" ] && export PATH="/usr/local/texlive/bin:$PATH"

setopt no_global_rcs

if [ -r "$ZDOTDIR/.zshenv_own" -a -f "$ZDOTDIR/.zshenv_own" ]; then
    source "$ZDOTDIR/.zshenv_own"
elif [ -r "$HOME/.zshenv_own" -a -f "$HOME/.zshenv_own" ]; then
    source "$HOME/.zshenv_own"
fi

[ -d "$HOME/.deno/bin" ] && export PATH="$HOME/.deno/bin:$PATH"
[ -n "$PNPM_HOME" -a -d "$PNPM_HOME" ] && export PATH="$PNPM_HOME:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -d "$HOME/.bun" ] && export BUN_INSTALL="$HOME/.bun" && export PATH="$BUN_INSTALL/bin:$PATH"
