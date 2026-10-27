#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "."')
dir=$(basename "$cwd")

branch=$(git --no-optional-locks -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)

model=$(echo "$input" | jq -r '.model.display_name // ""')

used=$(echo "$input" | jq -r 'if .context_window.remaining_percentage != null then 100 - .context_window.remaining_percentage else empty end')

# nerd font glyphs:  folder,  git branch,  chip,  gauge
ICON_DIR=''
ICON_GIT=''
ICON_MODEL=''
ICON_CTX=''

# cyan dir
printf '\033[36m%s %s\033[0m' "$ICON_DIR" "$dir"

# blue git branch
if [ -n "$branch" ]; then
  printf ' \033[34m%s\033[0m \033[31m%s\033[0m' "$ICON_GIT" "$branch"
fi

# model
if [ -n "$model" ]; then
  printf ' \033[2m%s %s\033[0m' "$ICON_MODEL" "$model"
fi

# context used: green <=20, yellow 21-49, red >=50
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  if [ "$used_int" -ge 50 ]; then
    color='\033[31m'
  elif [ "$used_int" -ge 21 ]; then
    color='\033[33m'
  else
    color='\033[32m'
  fi
  printf " ${color}%s %s%%\033[0m" "$ICON_CTX" "$used_int"
fi

# honcho memory segment (remove this block to drop it)
honcho=$(printf '%s\n' "$input" | bash "$HOME/.honcho/honcho-statusline.sh" 2>/dev/null)
if [ -n "$honcho" ]; then
  printf ' \033[2m·\033[0m %s' "$honcho"
fi

printf '\n'
