#!/bin/bash

set -ex

OS=$(uname -s)

# Install zsh, lab
if [ "$OS" = "Linux" ]; then
    sudo apt install -y zsh
    curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
elif [ "$OS" = "Darwin" ]; then
    brew install zsh lab
else
    echo "Not supported OS"
fi

# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change Default Shell
chsh -s /usr/bin/zsh

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Overwrite .zshrc
cp .zshrc ~/.zshrc
