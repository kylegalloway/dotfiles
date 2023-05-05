#!/usr/bin/env bash

# Base config
BASEDIR=${0:a:h}

# Zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md\(.N\); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

ln -sf "$BASEDIR"/zshrc "$HOME"/.zshrc
ln -sf "$BASEDIR"/zpreztorc "$HOME"/.zpreztorc
ln -sf "$BASEDIR"/prompt_kgalloway_setup "$HOME"/.zprezto/modules/prompt/functions/prompt_kgalloway_setup

chsh -s /bin/zsh
