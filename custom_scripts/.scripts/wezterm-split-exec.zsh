#! /bin/zsh

echo "debug: $@\nenv: `env`" > ~/last_x_exec.txt
pane=`wezterm cli split-pane --right`
echo NODE_OPTIONS="'$NODE_OPTIONS'" PWD="'$PWD'" $@ | wezterm cli send-text --pane-id $pane 
