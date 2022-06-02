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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

function toggle-touchpad() {
    if [[ $(synclient -l) =~ 'TouchpadOff[[:space:]]+\=[[:space:]]+([[:digit:]])' ]]; then
        if [[ $match[1] == '1' ]]; then
            synclient TouchpadOff=0
        else
            synclient TouchpadOff=1
        fi
    else
        echo "Couldn't get the 'TouchpadOff' property!"
    fi
}

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
