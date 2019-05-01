#
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
export LSCOLORS="exfxcxdxbxegedabagacad"

# Add General aliases.
if [ -f ~/Repos/dotfiles/generalAliases ]; then
    source ~/Repos/dotfiles/generalAliases
fi

# Setup Paths
export PATH=~/Repos/dotfiles/bin:$PATH

# Adds waiting dots for autocomplete like Oh-my-zsh
expand-or-complete-with-dots() {
   echo -n "\e[31m......\e[0m"
   zle expand-or-complete
   zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# This is amazing, it shows progress for processes longer than the given number of seconds
REPORTTIME=10

