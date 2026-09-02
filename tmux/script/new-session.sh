#!/usr/bin/env bash
# Create (and switch to) a new session.
# If no name is given, fall back to the next free numeric index.

name="$1"

if [ -z "$name" ]; then
  i=1
  while tmux has-session -t "$i" 2>/dev/null; do
    i=$((i + 1))
  done
  name="$i"
fi

tmux new-session -d -s "$name"
tmux switch-client -t "$name"
