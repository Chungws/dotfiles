# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start (New Mac)

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/opt/homebrew/bin:$PATH

# 2. Clone & setup
git clone https://github.com/Chungws/dotfiles.git ~/dotfiles
cd ~/dotfiles
brew install stow
make all
```

## Manual Steps After Setup
- Open tmux → `C-a Shift+I` to install tmux plugins
- Open nvim → LazyVim auto-installs plugins
- `gh auth login` for GitHub CLI
- Import `iterm2/tokyonight.itermcolors` in iTerm2

## Structure
```
zsh/        → .zshrc, .p10k.zsh
git/        → .gitconfig
tmux/       → .tmux.conf
karabiner/  → .config/karabiner/karabiner.json
skhd/       → .config/skhd/skhdrc
yabai/      → .config/yabai/yabairc
nvim/       → .config/nvim/lua/plugins/
iterm2/     → tokyonight.itermcolors
bin/        → bin/labmr
```

## Commands
```bash
make help     # Show all commands
make brew     # Install Homebrew packages
make stow     # Symlink dotfiles
make zsh      # Setup zsh + plugins
make macos    # Setup yabai + skhd
make nvim     # Setup Neovim
```
