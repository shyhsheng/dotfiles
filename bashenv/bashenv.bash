PS1='\[\033[01;32m\]\u \[\033[01;33m\]$(git_branch)\[\033[00m\]#\# [\[\033[01;34m\]\w\[\033[00m\]]\[\033[00;39m\] \$ '

alias e='nautilus'

alias nvimo='NVIM_APPNAME=nvim-old nvim'

alias wf='adb wait-for-device'
alias ar='adb wait-for-device root'
alias as='adb wait-for-device shell'
alias ars='ar;as'
alias arb='wf;adb reboot bootloader;foh'

alias fr='fastboot reboot'
alias frb='fastboot reboot-bootloader'
alias foh='fastboot oem hellow'

export CCACHE_DIR=~/.ccache
export USE_CCACHE=1

export PATH=~/.ccache:$PATH
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/android_tool/adb

#show the current branch in Git
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "("${ref#refs/heads/}") ";
}

function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));
    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

function tmux_sync_env() {
    command -v tmux >/dev/null 2>&1 || return
    [ -n "$TMUX" ] || return

    local vars="
        DISPLAY
        SSH_AUTH_SOCK
        SSH_CONNECTION
        SSH_CLIENT
        SSH_ASKPASS
        XAUTHORITY
    "

    local v val
    for v in $vars; do
        eval "val=\${$v}"
        [ -n "$val" ] && tmux set-environment -g "$v" "$val"
    done
}

. ~/.config/dotfiles/bashenv/android/android_envsetup.sh

. ~/.config/dotfiles//bashenv/completion/tig-completion.bash
. ~/.config/dotfiles/bashenv/completion/iw-completion.bash
. ~/.config/dotfiles/bashenv/completion/ifconfig-completion.bash
. ~/.config/dotfiles/bashenv/completion/adb-completion.bash
. ~/.config/dotfiles/bashenv/completion/fastboot-completion.bash

tmux_sync_env

