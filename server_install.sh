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

rm .zshrc

touch .zshrc

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

echo "Done. Installing Docker"

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker

sudo groupadd docker

sudo usermod -aG docker "$USER"
