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
