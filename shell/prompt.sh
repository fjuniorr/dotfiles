# git-aware prompt, git completion, and PS1
# git-aware-prompt: https://github.com/fjuniorr/git-aware-prompt

GITAWAREPROMPT="$HOME/.local/share/git-aware-prompt"
[ -f "$GITAWAREPROMPT/main.sh" ] && . "$GITAWAREPROMPT/main.sh"

# autocomplete git commands and branch names — first match wins
for _f in \
  "$HOME/.local/share/git-completion.bash" \
  /usr/share/bash-completion/completions/git \
  /etc/bash_completion.d/git ; do
  if [ -f "$_f" ]; then . "$_f"; break; fi
done
unset _f

export PS1="\[$(tput bold)\]\[\033[38;5;3m\]\W\[$(tput sgr0)\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
