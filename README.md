# Dotfiles

These funny little files live across my Home directory, and then I've realized
that sometimes them can simply go \*PUF\* by some imp hidden on the filesystem,
and sometimes I just want to share these across machines (work/home).

## My setup 

I use these dotfiles in a Linux and Mac environment, so expect some overlap.

## Bootstrapping

The files in this repository are organized as GNU Stow Packages, the way I set up
this repo whenever I have a new instalation is to clone it to my `$HOME` folder,
so installing the Stow packages is as easy as `stow <package name>`, for example,
for installing the zsh package it's just `stow zsh`. Otherwise refer to the GNU
Stow manual for further information, but mostly `stow -t "$HOME" <package>`
should do it.
