#!/bin/bash

# Check if Homebrew is installed
if ! type "brew" >/dev/null 2>&1; then
    echo "Homebrew not found, installing..."

    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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

    # Add Homebrew to PATH
    brew_path=$(which brew)
    if [[ ":$PATH:" != *":$brew_path:"* ]]; then
        echo "export PATH=$brew_path:\$PATH" >> "$HOME/$shell_config_file"
        echo "Homebrew added to PATH in $shell_config_file. Restart your shell to apply the changes."
    else
        echo "Homebrew is already in your PATH."
    fi

    # Load Homebrew environment variables
    eval "$(/opt/homebrew/bin/brew shellenv)"

else
    echo "Homebrew is already installed."

    # Install packages from Brewfile
    brew bundle install --file homebrew/Brewfile
fi