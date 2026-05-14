# Entry point sourced from ~/.bashrc by dotfiles install.sh
DOTFILES_SHELL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$DOTFILES_SHELL_DIR/aliases.sh"
. "$DOTFILES_SHELL_DIR/prompt.sh"

# atuin (ctrl+r shell history) wires itself into ~/.bashrc via its own installer
