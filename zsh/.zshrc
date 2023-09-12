export OH_MY_ZSH_CONFIG="$HOME/.oh-my-zshrc"

# If this file exists, the oh-my-zsh stow package was installed
if [[ -f $OH_MY_ZSH_CONFIG ]]; then
  . "$OH_MY_ZSH_CONFIG"
fi;

# Providing all aliases names to stdout, in order to use with j4-dmenu-desktop
function get-aliases-names() {
    while IFS= read -r line
    do
        if [[ $line =~ 'alias[[:space:]]+(.*)\=' ]]; then
            echo $match[1]
        fi
    done < "$HOME/.zsh_aliases"
}

# Include all aliases
. ~/.zsh_aliases

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
