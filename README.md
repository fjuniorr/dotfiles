# dotfiles

Personal dotfiles for bootstrapping a fresh machine (e.g. an exe.dev VM) with the
same global Git setup as my main machine.

## Install

```sh
git clone git@github.com:fjuniorr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

`install.sh` is idempotent and:

- symlinks `git/.gitconfig` -> `~/.gitconfig`
- symlinks `git/.gitignore_global` -> `~/.gitignore_global`
- symlinks `claude/settings.json` -> `~/.claude/settings.json` (Claude Code
  user settings — denies `AskUserQuestion`)
- wires `shell/init.sh` into `~/.bashrc` via a managed block (re-runs replace
  the block, never duplicate it) — this loads:
  - `shell/aliases.sh` — `claude` / `codex` aliases
  - `shell/prompt.sh` — git-aware prompt, git completion, and `PS1`
- installs `diff-so-fancy` (clones to `~/.local/share/diff-so-fancy`, symlinks
  into `~/.local/bin`) if it isn't already on `PATH` — used by the Git pager
  and diff highlighting
- clones `git-aware-prompt` to `~/.local/share/git-aware-prompt` and downloads
  `git-completion.bash` to `~/.local/share/`
- installs `atuin` (ctrl+r shell history) via its official installer, which
  also downloads `bash-preexec` and wires `~/.bashrc` itself

Any pre-existing `~/.gitconfig` / `~/.gitignore_global` is backed up with a
timestamp suffix before linking.

## Notes

- Editor is set to `vim` (the main machine uses `subl -w`, which isn't on a VM).
- If `~/.local/bin` isn't on your `PATH`, add it so `diff-so-fancy` is found.
- The prompt expects `bash`. After install, open a new shell or
  `source ~/.bashrc`.
