#!/bin/bash

echo "Starting install tools!"

sudo apt install zsh git -y

echo "Done. Install Neovim && LazyVim"

wget https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-arm64.tar.gz

tar xzvf nvim-linux-arm64.tar.gz

rm nvim-linux-arm64.tar.gz

mkdir .local

mkdir .local/bin

mv nvim-linux-arm64/bin/nvim .local/bin/

rm -rf nvim-linux-arm64

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

echo "Done. Install ohmyzsh && plugins"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"#!/bin/bash/

ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

cat <<'EOF' >>~/.zshrc

export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin"


ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  z
)

source $ZSH/oh-my-zsh.sh

EOF

echo "Done!"
