#!/usr/bin/env zsh

# bindkey -e

if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo "missing rbenv"; fi
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; else echo "missing direnv"; fi

alias irb="pry"
alias direnv="EDITOR=vim direnv"

if [ -r "$HOME/.zshrc_own" -a -f "$HOME/.zshrc_own" ]; then
    source "$HOME/.zshrc_own"
fi
if [ -r "$HOME/.zshenv_own" -a -f "$HOME/.zshenv_own" ]; then
    source "$HOME/.zshenv_own"
fi

[ -d "$HOME/.zsh/completions" ] && fpath=("$HOME/.zsh/completions" $fpath)

PROMPT="%F{cyan}%~ $%f "

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob
setopt IGNOREEOF

[ -f ~/.zplug/init.zsh ] && source ~/.zplug/init.zsh

if which zplug > /dev/null 2>&1; then
  zplug "b4b4r07/enhancd", use:init.sh
  zplug "zsh-users/zsh-syntax-highlighting", nice:10
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-autosuggestions", use:zsh-autosuggestions.zsh

  # commands
  zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
  zplug "simonwhitaker/gibo", as:command, use:"gibo"
  zplug "simonwhitaker/gibo", use:gibo-completion.zsh

  zplug "$HOME/.zsh", from:local

  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi

  zplug load --verbose
else
  echo "missing zplug"
fi

if which apm > /dev/null; then
    apm-install-sync() {
        echo "$@" | tr " " "\n" | grep -v '^-' | xargs -I {} sh -c "apm install --production {} && apm star {}"
    }
    apm-uninstall-sync() {
        echo "$@" | tr " " "\n" | grep -v '^-' | xargs -I {} sh -c "apm uninstall {} && apm unstar {}"
    }
fi
