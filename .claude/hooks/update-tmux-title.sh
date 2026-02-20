#!/bin/bash

# Guard against recursion — the inner `claude -p` call triggers this hook too
[ -n "$UPDATING_TMUX_TITLE" ] && exit 0
[ -z "$TMUX" ] && exit 0

INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')
[ -z "$PROMPT" ] && exit 0

export UPDATING_TMUX_TITLE=1

# Use claude CLI with Haiku to generate a short title
TITLE=$(echo "$PROMPT" | head -c 500 | claude -p --model haiku \
  "Output ONLY a 1-4 word title describing this task. No punctuation. No quotes. No explanation. Examples: Fix login bug, Shopify OAuth flow, Add dark mode, Refactor tests" \
  2>/dev/null)

# Fallback: first 4 words from prompt
if [ -z "$TITLE" ]; then
  TITLE=$(echo "$PROMPT" \
    | sed -E 's/^(can you |please |help me |I want to |I need to )//i' \
    | awk '{for(i=1;i<=4&&i<=NF;i++) printf "%s ", $i}' \
    | sed 's/ *$//' \
    | cut -c1-30)
fi

[ -n "$TITLE" ] && tmux rename-window "$TITLE"
exit 0
