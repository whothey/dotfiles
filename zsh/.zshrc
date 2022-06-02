export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda-mod"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_GB.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

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
