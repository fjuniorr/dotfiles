#!/usr/bin/env bash
set -euo pipefail

if [ -f "$HOME/.local/share/git-completion.bash" ]; then
  exit 0
fi

mkdir -p "$HOME/.local/share"
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
  -o "$HOME/.local/share/git-completion.bash"
