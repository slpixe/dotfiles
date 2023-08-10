#!/bin/bash

if ! type "brew" >/dev/null 2>&1; then
    echo "Homebrew not found, install it first"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    exit 1
fi

brew bundle install --file homebrew/Brewfile