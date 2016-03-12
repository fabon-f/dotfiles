#!/bin/sh

if [ -e "$HOME/.enhancd" ]; then
    echo "$HOME/.exenv already exist"
    echo "Aborting exenv installation"
    exit 1
fi

git clone https://github.com/mururu/exenv.git "$HOME/.exenv"
git clone https://github.com/mururu/elixir-build.git "$HOME/.exenv/plugins/elixir-build"
