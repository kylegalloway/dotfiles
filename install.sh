#!/usr/bin/env bash

# Base config
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASEDIR="$SCRIPTDIR"

# gdb
"$BASEDIR"/gdb/install.py

# User Files
"$BASEDIR"/homefiles/install.py

# Sublime (Need to uncomment if wanted)
# "$BASEDIR"/sublime/install.py

# Vim
"$BASEDIR"/homefiles/vim/install.py

# Zsh
"$BASEDIR"/linux/zsh/install.sh

# Fonts
"$BASEDIR"/fonts/install.py

