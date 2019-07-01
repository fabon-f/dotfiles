#!/usr/bin/env zsh

# bindkey -e

if which direnv > /dev/null; then eval "$(direnv hook zsh)"; else echo "missing direnv"; fi

alias irb="pry"
alias direnv="EDITOR=vim direnv"

if [ -r "$HOME/.zshrc_own" -a -f "$HOME/.zshrc_own" ]; then
    source "$HOME/.zshrc_own"
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

[ -f ~/.zplugin/bin/zplugin.zsh ] && source ~/.zplugin/bin/zplugin.zsh

if which zplugin > /dev/null 2>&1; then
  zplugin ice pick"init.sh"
  zplugin light "b4b4r07/enhancd"

  zplugin ice blockf
  zplugin light "zsh-users/zsh-completions"

  zplugin ice pick"zsh-autosuggestions.zsh"
  zplugin light "zsh-users/zsh-autosuggestions"

  zplugin ice lucid wait"0"
  zplugin light zdharma/fast-syntax-highlighting

  zplugin light "$HOME/.zsh"

  zplugin ice from"gh-r" as"program" mv"jq* -> jq"; zplugin load "stedolan/jq"
else
  echo "missing zplugin"
fi

autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

asdf() {
  unset -f asdf
  source $HOME/.asdf/asdf.sh
  asdf "$@"
}

source $HOME/.asdf/completions/asdf.bash
