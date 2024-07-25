#!/bin/bash

set -ex

OS=$(uname -s)
ZSH_CUSTOM="~/.oh-my-zsh/custom"

# Install zsh, lab, nvim, tmux
if [ "$OS" = "Linux" ]; then
  sudo apt install -y zsh nvim tmux ripgrep fzf fd-find bat eza
  curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
elif [ "$OS" = "Darwin" ]; then
  brew install zsh lab nvim tmux ripgrep fzf fd bat eza tlrc lazygit
else
  echo "Not supported OS"
fi

mv ~/.config/ ~/.config.back

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

# Overwrite .p10k.sh
cp .p10k.zsh ~/.p10k.zsh

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Overwrite .tmux.conf
mv ~/.tmux.conf ~/.tmux.conf.back
cp .tmux.conf ~/.tmux.conf
# then open tmux session and source file .tmux.conf (C-b :source-file ~/.tmux.conf) next, install plugins (C-a shift i)

# Neovim setup
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git
cp vim-tmux-navigator.lua ~/.config/nvim/lua/plugins/vim-tmux-navigator.lua
cp neo-tree.lua ~/.config/nvim/lua/plugins/neo-tree.lua

# fzf setup
git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh

# bat setup
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
cd -
bat cache --build

# zoxide setup
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Overwrite .zshrc
mv ~/.zshrc ~/.zshrc.back
cp .zshrc ~/.zshrc

# Source file .zshrc
source ~/.zshrc
