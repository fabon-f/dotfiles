#!/bin/sh

set -eu

if [ -e "$HOME/.enhancd" ]; then
    echo "$HOME/.enhancd already exist"
    echo "Aborting enhancd installation"
    exit 1
fi

git clone https://github.com/b4b4r07/enhancd.git "$HOME/.enhancd"
