#!/bin/sh

set -eu

FORMULAS=`brew list`
ALREADY_INSTALLED=1

for FORMULA in coreutils curl deno direnv exiftool fd ffmpeg findutils fswatch fzf fzy gawk git git-lfs gnu-sed grep hadolint imagemagick jq mecab node mupdf-tools pandoc pnpm poppler rbenv ripgrep rlwrap rsync shellcheck skktools sl tig tldr tmux tree vim wget yt-dlp zsh
do
    if ! echo "$FORMULAS" | tr " " "\n" | grep "^$FORMULA$" > /dev/null; then
        echo "$FORMULA not found"
        brew install $FORMULA
        $ALREADY_INSTALLED=0
    fi
done

[ $ALREADY_INSTALLED -eq 1 ] && echo "All formulas are already installed"
