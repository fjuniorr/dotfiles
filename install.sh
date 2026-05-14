#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok    $dest already linked"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
    echo "back  moving existing $dest -> $backup"
    mv "$dest" "$backup"
  fi
  ln -s "$src" "$dest"
  echo "link  $dest -> $src"
}

link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

if command -v diff-so-fancy >/dev/null 2>&1; then
  echo "ok    diff-so-fancy already installed"
else
  DSF_DIR="$HOME/.local/share/diff-so-fancy"
  mkdir -p "$HOME/.local/bin"
  if [ -d "$DSF_DIR/.git" ]; then
    echo "get   updating diff-so-fancy"
    git -C "$DSF_DIR" pull --quiet --ff-only
  else
    echo "get   installing diff-so-fancy -> $DSF_DIR"
    git clone --quiet --depth 1 https://github.com/so-fancy/diff-so-fancy.git "$DSF_DIR"
  fi
  ln -sf "$DSF_DIR/diff-so-fancy" "$HOME/.local/bin/diff-so-fancy"
  echo "ok    installed diff-so-fancy"
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) echo "warn  add ~/.local/bin to your PATH:  export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
  esac
fi

echo "done"
