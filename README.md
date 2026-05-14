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
- installs `diff-so-fancy` (clones to `~/.local/share/diff-so-fancy`, symlinks
  into `~/.local/bin`) if it isn't already on `PATH` — used by the Git pager
  and diff highlighting

Any pre-existing `~/.gitconfig` / `~/.gitignore_global` is backed up with a
timestamp suffix before linking.

## Notes

- Editor is set to `vim` (the main machine uses `subl -w`, which isn't on a VM).
- If `~/.local/bin` isn't on your `PATH`, add it so `diff-so-fancy` is found.
