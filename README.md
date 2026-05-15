# dotfiles

Minimal dotfiles for bootstrapping fresh exe.dev VMs via
[chezmoi](https://chezmoi.io). Not intended for use on my main machine —
it's just a reference there.

## Install (on a fresh VM)

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply fjuniorr
```

This installs chezmoi if missing, clones this repo, applies the dotfiles,
and runs the install scripts.

What it does:

- writes `~/.gitconfig` and `~/.gitignore_global`
- writes `~/.claude/settings.json` (Claude Code user settings — denies
  `AskUserQuestion`)
- writes `~/.local/share/dotfiles/{init,aliases,prompt}.sh`
- runs `modify_dot_bashrc` to inject a managed source block into
  `~/.bashrc` that loads `~/.local/share/dotfiles/init.sh`, which sources
  `aliases.sh` (`claude` / `codex` aliases) and `prompt.sh` (git-aware
  prompt + git completion + `PS1`)
- runs install scripts after applying files (alphabetical order):
  - `run_onchange_install-atuin.sh` — atuin (ctrl+r shell history) via its
    official installer; wires `~/.bashrc` and writes hooks into the
    deployed `~/.claude/settings.json` (the source repo stays minimal)
  - `run_onchange_install-diff-so-fancy.sh` — clones to
    `~/.local/share/diff-so-fancy`, symlinks into `~/.local/bin`
  - `run_onchange_install-git-aware-prompt.sh` — clones to
    `~/.local/share/git-aware-prompt`
  - `run_onchange_install-git-completion.sh` — downloads
    `git-completion.bash` to `~/.local/share/`

## Updating a VM

```sh
chezmoi update
```

## Notes

- Editor is set to `vim` (the main machine uses `subl -w`, which isn't on a VM).
- If `~/.local/bin` isn't on `PATH`, add it so `diff-so-fancy` is found.
- The prompt expects `bash`. After install, open a new shell or
  `source ~/.bashrc`.
