#!/usr/bin/env bash
set -euo pipefail

if command -v diff-so-fancy >/dev/null 2>&1; then
  exit 0
fi

mkdir -p "$HOME/.local/bin" "$HOME/.local/share"
if [ ! -d "$HOME/.local/share/diff-so-fancy/.git" ]; then
  git clone --quiet --depth 1 https://github.com/so-fancy/diff-so-fancy.git \
    "$HOME/.local/share/diff-so-fancy"
fi
ln -sf "$HOME/.local/share/diff-so-fancy/diff-so-fancy" "$HOME/.local/bin/diff-so-fancy"
