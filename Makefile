.PHONY: all brew zsh stow nvim macos help

all: brew zsh stow nvim ## Full setup for new Mac
	@echo ""
	@echo "✅ Done! Manual steps:"
	@echo "  1. Restart terminal (or: source ~/.zshrc)"
	@echo "  2. Open tmux → C-a Shift+I to install plugins"
	@echo "  3. Open nvim → LazyVim auto-installs plugins"
	@echo "  4. gh auth login"
	@echo "  5. iTerm2 → Preferences → Profiles → Colors → select tokyonight_night"

brew: ## Install Homebrew packages
	brew install stow
	brew bundle --file=Brewfile

zsh: ## Setup zsh, plugins, and shell tools
	@echo "==> oh-my-zsh"
	@if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; \
		rm -f $$HOME/.zshrc; \
	fi
	@echo "==> zsh-syntax-highlighting"
	@if [ ! -d "$$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
			$$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; \
	fi
	@echo "==> zsh-autosuggestions"
	@if [ ! -d "$$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then \
		git clone https://github.com/zsh-users/zsh-autosuggestions \
			$$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
	fi
	@echo "==> powerlevel10k"
	@if [ ! -d "$$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then \
		git clone https://github.com/romkatv/powerlevel10k.git \
			$$HOME/.oh-my-zsh/custom/themes/powerlevel10k; \
	fi
	@echo "==> tmux plugin manager"
	@if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm $$HOME/.tmux/plugins/tpm; \
	fi
	@echo "==> fzf-git.sh"
	@if [ ! -d "$$HOME/fzf-git.sh" ]; then \
		git clone https://github.com/junegunn/fzf-git.sh.git $$HOME/fzf-git.sh; \
	fi
	@echo "==> bat theme (tokyonight)"
	@mkdir -p "$$(bat --config-dir)/themes"
	@curl -sfLo "$$(bat --config-dir)/themes/tokyonight_night.tmTheme" \
		https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
	@bat cache --build 2>/dev/null || true
	@echo "==> n (Node.js version manager)"
	@if [ ! -d "$$HOME/.n" ]; then \
		curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts; \
	fi
	@echo "==> Rust"
	@if ! command -v rustup >/dev/null; then \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; \
	fi
	@echo "==> iTerm2 color scheme"
	@open iterm2/tokyonight.itermcolors 2>/dev/null || true
	@echo "==> Default shell → zsh"
	@if [ "$$SHELL" != "/bin/zsh" ]; then \
		chsh -s /bin/zsh; \
	fi

stow: ## Symlink all dotfiles via stow
	@# Remove oh-my-zsh generated .zshrc if not already a symlink
	@if [ -f "$$HOME/.zshrc" ] && [ ! -L "$$HOME/.zshrc" ]; then \
		mv $$HOME/.zshrc $$HOME/.zshrc.bak; \
	fi
	stow -v -d . -t ~ zsh git tmux karabiner skhd yabai nvim bin

nvim: ## Setup Neovim with LazyVim
	@if [ ! -d "$$HOME/.config/nvim" ]; then \
		git clone https://github.com/LazyVim/starter $$HOME/.config/nvim && \
		rm -rf $$HOME/.config/nvim/.git; \
	fi
	stow -v -d . -t ~ nvim

macos: ## Setup macOS window management (yabai + skhd)
	stow -v -d . -t ~ skhd yabai
	yabai --start-service
	skhd --start-service

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
