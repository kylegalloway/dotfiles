#!/bin/zsh
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export SUBLIME=subl
export EDITOR="$SUBLIME --wait"
export VISUAL=$EDITOR
export LSCOLORS="exfxcxdxbxegedabagacad"
export DEFAULT_USER=kgalloway

# Don't share history
setopt no_share_history

# 256 Colors
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

# Add General aliases.
if [ -f ~/Repos/dotfiles/aliases/generalAliases ]; then
    source ~/Repos/dotfiles/aliases/generalAliases
fi

# Setup Paths
export PATH=~/Repos/dotfiles/bin:$PATH
export PATH=/opt/clang/bin:$PATH
export PATH=/opt/qtcreator/bin:$PATH
export PYTHONPATH=~/Repos/dotfiles/python:$PYTHONPATH

# Adds waiting dots for autocomplete like Oh-my-zsh
expand-or-complete-with-dots() {
   echo -n "\e[31m......\e[0m"
   zle expand-or-complete
   zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

