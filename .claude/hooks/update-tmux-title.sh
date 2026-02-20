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
  "You are a title generator. Respond with ONLY a 1-4 word title (max 30 chars) for the task described. NEVER output sentences, explanations, quotes, or punctuation. NEVER start with 'Sure' or 'Here'. Just the title words.
Good: Fix login bug
Good: Shopify OAuth flow
Good: Refactor auth middleware
Bad: Here is a title: Fix the bug
Bad: \"Refactoring Tests\"
Bad: Sure! How about: Fix login" \
  2>/dev/null)

# Post-process: strip quotes/punctuation, limit to 4 words and 30 chars
if [ -n "$TITLE" ]; then
  TITLE=$(echo "$TITLE" \
    | tr -d '""'\''`' \
    | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' \
    | sed -E 's/^(Sure[!,.]?|Here[:]?|Title[:]?) *//i' \
    | sed -E 's/[.!?,:;]+$//' \
    | awk '{for(i=1;i<=4&&i<=NF;i++) printf "%s ", $i}' \
    | sed 's/ *$//' \
    | cut -c1-30)
fi

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
