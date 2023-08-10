#!/bin/bash

if ! type "brew" >/dev/null 2>&1; then
    echo "Homebrew not found, install it first"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Determine the Homebrew installation path
    brew_path=$(which brew)

    # Determine the user's default shell
    user_shell=$(basename "$SHELL")

    # Define shell-specific configuration file names
    case "$user_shell" in
        bash)
            shell_config_file=".bashrc"
            ;;
        zsh)
            shell_config_file=".zshrc"
            ;;
        *)
            echo "Unsupported shell: $user_shell"
            exit 1
            ;;
    esac

    # Add Homebrew to PATH if it's not already present
    if [[ ":$PATH:" != *":$brew_path:"* ]]; then
        echo "export PATH=$brew_path:\$PATH" >> "$HOME/$shell_config_file"
        echo "Homebrew added to PATH in $shell_config_file. Restart your shell to apply the changes."
    else
        echo "Homebrew is already in your PATH."
    fi

    eval "$(/opt/homebre/bin/brew shellenv)"

    exit 1
fi

brew bundle install --file homebrew/Brewfile