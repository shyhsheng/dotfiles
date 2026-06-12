#!/bin/bash

who=$(whoami)

bashrc_f="/home/$who/.bashrc"

if [ -z $1 ]; then
    while read line
    do
        if [[ $line =~ "bashenv/bashenv.bash" ]]; then
            echo "already installed"
            exit
        fi
    done < $bashrc_f

    echo ". ~/.config/dotfiles/bashenv/bashenv.bash" >> ~/.bashrc
    . ~/.bashrc
fi

link_if_not_exists() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        echo "[SKIP] symlink already exists: $dst"
        return 1
    elif [ -e "$dst" ]; then
        echo "[SKIP] target already exists and is not a symlink: $dst"
        return 1
    else
        ln -s "$src" "$dst"
        echo "[LINK] $dst -> $src"
        return 0
    fi
}

link_if_not_exists ~/.config/dotfiles/nvim ~/.config/nvim
link_if_not_exists ~/.config/dotfiles/tmux ~/.config/tmux
link_if_not_exists ~/.config/dotfiles/kitty ~/.config/kitty
link_if_not_exists ~/.config/dotfiles/bashenv/inputrc ~/.inputrc
link_if_not_exists ~/.config/dotfiles/bashenv/systemd/user/tmux.service ~/.config/systemd/user/tmux.service \
                    && { systemctl --user daemon-reload
                       systemctl --user enable tmux.service
                       systemctl --user start tmux.service
                       loginctl enable-linger $USER
                    }
link_if_not_exists ~/.config/dotfiles/sesh ~/.config/sesh

echo "Start Setting Git"

name=$(git config user.name)
email=$(git config user.email)

if [ -z ${name} ]; then
    read -p "Name: " name
fi
if [ -z ${email} ]; then
    read -p "Email: " email
fi

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
echo "Setting Git successfully"

. /etc/os-release

if [ "${VERSION_ID%%.*}" -lt 24 ]; then

    if ! command -v tree-sitter >/dev/null 2>&1; then
        npm install -g tree-sitter-cli@0.24.7
    fi

    if ! command -v node >/dev/null 2>&1; then
        curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
        sudo apt-get install -y nodejs
    fi
fi

if ! command -v fdfind >/dev/null 2>&1; then
    echo "fd-find not found, installing"
    sudo apt install fd-find
fi

if ! command -v kitty >/dev/null 2>&1; then
    echo "kitty nodt found, installing"
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    mkdir -p ~/.local/bin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty

    sudo apt install kitty-terminfo
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

if [ "${VERSION_ID%%.*}" -ge 24 ]; then
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
        git config --global delta.syntax-theme "Catppuccin Mocha"
        git config --global merge.conflictStyle zdiff3
    fi
fi

if ! command -v zoxide >/dev/null 2>&1; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

if ! command -v sesh >/dev/null 2>&1; then
    if ! command -v go >/dev/null 2>&1; then
        echo "sesh not found , installing"
        go install github.com/joshmedeski/sesh/v2@latest
        sesh completion bash > sesh-completion.bash
        sudo mv sesh-completion.bash /etc/bash_completion.d/
    else
        echo "go not found, skip installing sesh"
    fi
fi

### for tmux-window-name
python3 -m pip install --user libtmux
python3 -m pip install dataclasses --user
