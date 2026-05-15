#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/share"
if [ -d "$HOME/.local/share/git-aware-prompt/.git" ]; then
  git -C "$HOME/.local/share/git-aware-prompt" pull --quiet --ff-only
else
  git clone --quiet --depth 1 https://github.com/fjuniorr/git-aware-prompt.git \
    "$HOME/.local/share/git-aware-prompt"
fi
