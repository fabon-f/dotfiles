#!/bin/sh

if which brew > /dev/null || [ -x /usr/local/bin/brew ]; then
    echo "Homebrew is already installed"
    exit 1
fi

echo "install Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
