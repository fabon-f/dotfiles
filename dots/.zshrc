#!/usr/bin/env zsh

bindkey -e

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

[ -f ~/.zinit/bin/zinit.zsh ] && source ~/.zinit/bin/zinit.zsh
# Just for the backward compatibility
[ -f ~/.zplugin/bin/zplugin.zsh ] && source ~/.zplugin/bin/zplugin.zsh

if which zinit > /dev/null 2>&1; then
  zinit ice lucid wait"0" pick"init.sh"
  zinit light "b4b4r07/enhancd"

  zinit ice blockf
  zinit light "zsh-users/zsh-completions"

  zinit ice lucid wait"0" pick"zsh-autosuggestions.zsh"
  zinit light "zsh-users/zsh-autosuggestions"

  zinit ice lucid wait"0" atload'unset "FAST_HIGHLIGHT[chroma-ruby]"'
  zinit light zdharma/fast-syntax-highlighting

  zinit ice lucid wait"0" pick"k.sh"
  zinit light "supercrabtree/k"

  zinit ice lucid wait"0"
  zinit light "mollifier/cd-gitroot"

  zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
  zinit light sindresorhus/pure

  if ! which jq > /dev/null 2>&1; then
    zinit ice from"gh-r" as"program" mv"jq* -> jq"; zinit load "stedolan/jq"
  fi
else
  echo "missing zinit"
fi

() {
  local files=($HOME/.zsh/**/*.zsh)
  for f in $files; do source $f; done
}

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

if [ -r "$HOME/.asdf/completions/asdf.bash" -a -f "$HOME/.asdf/completions/asdf.bash" ]; then
    source "$HOME/.asdf/completions/asdf.bash"
fi
