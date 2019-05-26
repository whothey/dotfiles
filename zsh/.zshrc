ANTIGEN_SRC=/usr/share/zsh/share/antigen.zsh

if [[ -f $ANTIGEN_SRC ]]; then
    source $ANTIGEN_SRC

    antigen use oh-my-zsh

    antigen bundle git
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions

    antigen theme halfo/lambda-mod-zsh-theme

    antigen apply
fi;

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

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
