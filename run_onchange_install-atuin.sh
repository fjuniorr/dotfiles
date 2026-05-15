#!/usr/bin/env bash
set -euo pipefail

# atuin's installer wires ~/.bashrc and writes claude code hooks into
# ~/.claude/settings.json itself. By running after chezmoi applies files,
# atuin sees the deployed settings.json and adds its hooks to the live
# copy without touching the source repo.
if command -v atuin >/dev/null 2>&1 || [ -x "$HOME/.atuin/bin/atuin" ]; then
  exit 0
fi
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive
