#!/usr/bin/env bash
set -euo pipefail

"$HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh"

while IFS= read -r window; do
  tmux resize-window -A -t "$window"
  tmux set-window-option -u -t "$window" window-size
done < <(tmux list-windows -a -F '#{session_name}:#{window_index}')

tmux display-message 'Restored sessions and resized windows'
