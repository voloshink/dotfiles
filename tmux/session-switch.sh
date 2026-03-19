#!/usr/bin/env bash
# Fast session switcher — bypasses tmux-fzf's .envs and fzf-tmux overhead.

current_session=$(tmux display-message -p '#S')
sessions=$(tmux list-sessions -F '#S' | grep -v "^${current_session}$")

[[ -z "$sessions" ]] && exit 0

tmpfile=$(mktemp "${TMPDIR:-/tmp}/tmux-session-XXXXXX")
resultfile=$(mktemp "${TMPDIR:-/tmp}/tmux-session-XXXXXX")
printf "%s\n" "$sessions" > "$tmpfile"

tmux display-popup -E -w 62% -h 38% \
  "fzf --no-tmux --border --header='Switch session' < '$tmpfile' > '$resultfile'"

target=$(cat "$resultfile")
rm -f "$tmpfile" "$resultfile"

[[ -n "$target" ]] && tmux switch-client -t "$target"
exit 0
