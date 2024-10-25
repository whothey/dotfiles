export OH_MY_ZSH_CONFIG="$HOME/.oh-my-zshrc"

# If this file exists, the oh-my-zsh stow package was installed
if [[ -f $OH_MY_ZSH_CONFIG ]]; then
  . "$OH_MY_ZSH_CONFIG"
fi;

# Include all aliases
. ~/.zsh_aliases

if command -v tmux &> /dev/null && [[ "$AUTO_START_TMUX" =~ "true" ]] && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
