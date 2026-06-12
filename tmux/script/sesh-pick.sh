#!/usr/bin/env bash

current="$(tmux display-message -p '#S')"

list_sessions() {
  sesh list --icons | awk -v cur="$current" '
    $2 == cur { print "● " $0; next }
    { print "  " $0 }
  '
}

selected="$(
  list_sessions | fzf-tmux -p 80%,70% \
    --no-sort --ansi \
    --border-label ' sesh ' \
    --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
    --bind 'tab:down,btab:up' \
    --bind "ctrl-a:change-prompt(⚡  )+reload($0)" \
    --bind "ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)" \
    --bind "ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)" \
    --bind "ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)" \
    --bind "ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)" \
    --preview-window 'right:55%' \
    --preview 'sesh preview {2..}'
)"

[ -z "$selected" ] && exit 0

target="$(echo "$selected" | sed 's/^● //; s/^  //')"

sesh connect "$target"
