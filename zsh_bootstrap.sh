#!/bin/bash

set -ex

OS=$(uname -s)
ZSH_CUSTOM="~/.oh-my-zsh/custom"

# Install zsh, lab, nvim, tmux
if [ "$OS" = "Linux" ]; then
    sudo apt install -y zsh nvim tmux
    curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
elif [ "$OS" = "Darwin" ]; then
    brew install zsh lab nvim tmux
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

# Install powerlevel10k for themes
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Overwrite .zshrc
cp .zshrc ~/.zshrc

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Overwrite .tmux.conf
cp .tmux.conf ~/.tmux.conf
# then open tmux session and source file .tmux.conf (C-b :source-file ~/.tmux.conf) next, install plugins (C-a shift i)

# Source file .zshrc
source ~/.zshrc
