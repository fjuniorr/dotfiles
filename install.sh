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

clone_or_update() {
  local repo="$1" dir="$2"
  if [ -d "$dir/.git" ]; then
    echo "get   updating $(basename "$dir")"
    git -C "$dir" pull --quiet --ff-only
  else
    echo "get   cloning $(basename "$dir")"
    git clone --quiet --depth 1 "$repo" "$dir"
  fi
}

wire_bashrc() {
  local rc="$HOME/.bashrc" target="$DOTFILES_DIR/shell/init.sh"
  [ -f "$rc" ] || touch "$rc"
  # drop any previously managed block, then re-append a fresh one
  awk '
    /^# >>> dotfiles.*>>>$/ {skip=1}
    !skip {print}
    /^# <<< dotfiles.*<<<$/ {skip=0; next}
  ' "$rc" > "$rc.dotfiles.tmp" && mv "$rc.dotfiles.tmp" "$rc"
  {
    echo "# >>> dotfiles >>>"
    echo "[ -f \"$target\" ] && . \"$target\""
    echo "# <<< dotfiles <<<"
  } >> "$rc"
  echo "edit  wired shell/init.sh into $rc"
}

# --- git config ---
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

# --- shell config (aliases + prompt) ---
wire_bashrc

# --- diff-so-fancy (git pager / diff highlighting) ---
if command -v diff-so-fancy >/dev/null 2>&1; then
  echo "ok    diff-so-fancy already installed"
else
  mkdir -p "$HOME/.local/bin"
  clone_or_update https://github.com/so-fancy/diff-so-fancy.git "$HOME/.local/share/diff-so-fancy"
  ln -sf "$HOME/.local/share/diff-so-fancy/diff-so-fancy" "$HOME/.local/bin/diff-so-fancy"
  echo "ok    installed diff-so-fancy"
fi

# --- git-aware-prompt ---
clone_or_update https://github.com/fjuniorr/git-aware-prompt.git "$HOME/.local/share/git-aware-prompt"

# --- git bash completion ---
if [ ! -f "$HOME/.local/share/git-completion.bash" ]; then
  mkdir -p "$HOME/.local/share"
  echo "get   downloading git-completion.bash"
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    -o "$HOME/.local/share/git-completion.bash"
fi
echo "ok    git-completion.bash present"

# --- atuin (ctrl+r shell history) ---
# its installer downloads bash-preexec and wires ~/.bashrc itself (idempotently)
if command -v atuin >/dev/null 2>&1 || [ -x "$HOME/.atuin/bin/atuin" ]; then
  echo "ok    atuin already installed"
else
  echo "get   installing atuin"
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive
fi

case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) echo "warn  add ~/.local/bin to your PATH:  export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
esac

echo "done  open a new shell or run: source ~/.bashrc"
