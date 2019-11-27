#! /usr/bin/env zsh
echo ${(k)commands} | tr ' ' '\n' | sort -d | fzf --border --reverse | xargs -r swaymsg -t command exec
