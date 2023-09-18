# Dotfiles

These funny little files live across my Home directory, and then I've realized
that sometimes them can simply go \*PUF\* by some imp hidden on the filesystem,
and sometimes I just want to share these across machines (work/home).

## My setup 

I use these dotfiles in a Linux and Mac environment, so expect some overlap.

## Bootstrapping

The folders in this repository are organized as GNU Stow Packages and installing
packages is as easy as `stow <package name>`, for example, to install the `zsh`
package it is just a `stow zsh` away if this repo was cloned from you $HOME
folder, otherwise `stow -t "$HOME" <package>` should do it.

Also, there are some packages like `oh-my-zsh`, `nvim` and `tmux` that require
submodules to be updated, so `git submodules update --init` should run to enable
all features of all packages.

