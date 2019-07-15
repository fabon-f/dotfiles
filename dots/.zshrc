#!/usr/bin/env zsh

# bindkey -e

if which direnv > /dev/null; then eval "$(direnv hook zsh)"; else echo "missing direnv"; fi

alias irb="pry"
alias direnv="EDITOR=vim direnv"

if (( $+commands[gls] )) ; then
  # Use coreutils' ls in Mac
  alias ls='gls --color=auto'
fi

if [ -r "$HOME/.zshrc_own" -a -f "$HOME/.zshrc_own" ]; then
    source "$HOME/.zshrc_own"
fi

[ -d "$HOME/.zsh/completions" ] && fpath=("$HOME/.zsh/completions" $fpath)

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
  zplugin ice lucid wait"0" pick"init.sh"
  zplugin light "b4b4r07/enhancd"

  zplugin ice blockf
  zplugin light "zsh-users/zsh-completions"

  zplugin ice pick"zsh-autosuggestions.zsh"
  zplugin light "zsh-users/zsh-autosuggestions"

  zplugin ice lucid wait"0" atload'unset "FAST_HIGHLIGHT[chroma-ruby]"'
  zplugin light zdharma/fast-syntax-highlighting

  zplugin ice pick"k.sh"
  zplugin light "supercrabtree/k"

  zplugin light "mollifier/cd-gitroot"

  zplugin ice pick"async.zsh" src"pure.zsh"
  zplugin light sindresorhus/pure

  zplugin light "$HOME/.zsh"

  zplugin ice from"gh-r" as"program" mv"jq* -> jq"; zplugin load "stedolan/jq"
else
  echo "missing zplugin"
fi

autoload -Uz compinit

# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
_zpcompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZDOTDIR:-$HOME}/.zcompdump
  local zcdc="$zcd.zwc"
  # Compile zcompdump in background
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}

_zpcompinit_custom

asdf() {
  unset -f asdf
  source $HOME/.asdf/asdf.sh
  asdf "$@"
}

autoload -Uz bashcompinit && bashcompinit
source $HOME/.asdf/completions/asdf.bash
