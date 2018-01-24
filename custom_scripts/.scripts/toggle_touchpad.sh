#!/bin/zsh -e
if [[ $(synclient -l) =~ 'TouchpadOff[[:space:]]+\=[[:space:]]+([[:digit:]])' ]]; then
    if [[ $match[1] == '1' ]]; then
        synclient TouchpadOff=0
    else
        synclient TouchpadOff=1
    fi
else
    echo "Couldn't get the 'TouchpadOff' property!"
fi
