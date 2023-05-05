#! /usr/bin/zsh
# Zsh Setup Script
# by Kyle Galloway
# setup_zsh.sh
# Uncomment the command below to see the commands that are being run (prefaced with `+`)
# set -x

zsh_setup(){
    echo "Installing prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
}

zsh_setup
