#!/bin/bash

who=$(whoami)

bashrc_f="/home/$who/.bashrc"

while read line
do
    if [[ $line =~ "bashenv/bashenv.bash" ]]; then
        echo "already installed"
        exit
    fi
done < $bashrc_f

echo ". ~/.config/dotfiles/bashenv/bashenv.bash" >> ~/.bashrc
. ~/.bashrc


ln -s ~/.config/dotfiles/nvim ~/.config/nvim
ln -s ~/.config/dotfiles/tmux ~/.config/tmux
ln -s ~/.config/dotfiles/kitty ~/.config/kitty
ln -s ~/.config/dotfiles/bashenv/inputrc ~/.inputrc

echo "Setting git Start"
read -p "Name: " name
read -p "Email: " email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.cia "commit --amend"
git config --global alias.st status
git config --global alias.br branch
git config --global alias.chp cherry-pick
git config --global alias.rb rebase
git config --global color.ui auto
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
if [[ -f "/snap/bin/nvim" ]]; then
    git config --global core.editor /snap/bin/nvim
else
    git config --global core.editor /usr/bin/vim
fi
git config --global core.fileMode false
git config --global merge.tool kdiff3
git config --global diff.tool kdiff3
echo "Setting git End"

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs
sudo apt install fd-find

. /etc/os-release
if [ "${VERSION_ID%%.*}" -lt 24 ]; then
    npm install -g tree-sitter-cli@0.24.7
fi

if ! command -v kitty >/dev/null 2>&1; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    mkdir -p ~/.local/bin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
fi

if ! command -v lazygit >/dev/null 2>&1; then
    echo "lazygit not found, installing..."

    LAZYGIT_VERSION=$(
        curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
        | grep -Po '"tag_name": "v\K[^"]*'
    )

    TMP_DIR=$(mktemp -d)

    curl -Lo "${TMP_DIR}/lazygit.tar.gz" \
        "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

    tar xf "${TMP_DIR}/lazygit.tar.gz" -C "${TMP_DIR}" lazygit

    sudo install "${TMP_DIR}/lazygit" /usr/local/bin

    rm -rf "${TMP_DIR}"

    echo "lazygit ${LAZYGIT_VERSION} installed successfully"
fi

if ! command -v delta >/dev/null 2>&1; then
    echo "delta not found, installing"
    DELTA_VERSION=$(
        curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" \
        | grep -Po '"tag_name": "\K[^"]*'
    )
    TMP_DIR=$(mktemp -d)

    curl -Lo "${TMP_DIR}/delta_amd64.deb" \
        "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"

    sudo dpkg -i "${TMP_DIR}/delta_amd64.deb"

    rm -rf "${TMP_DIR}"
    echo "delta ${DELTA_VERSION} installed successfully"

    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate true
    git config --global delta.dark true
    git config --global delta.line-numbers true
    #
    # Command for list all syntax themes
    # $ delta --list-syntax-themes
    #
    # Quickly test theme :
    # $ git diff | delta --syntax-theme Nord
    #
    git config --global delta.syntax-theme = "Catppuccin Mocha"
    git config --global merge.conflictStyle zdiff3
fi
