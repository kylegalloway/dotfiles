# Install Script
# by Kyle Galloway
# setup.sh
# 
# Need to run setup-repos first

sudo add-apt-repository ppa:linrunner/tlp
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get upgrade

LIST_OF_APPS="thermald vim cmus zsh flashplugin-installer gcc g++ clang python-pip python-dev build-essential curl silversearcher-ag htop tudu terminator qalc cloc sublime-text-installer"

sudo apt-get install -y $LIST_OF_APPS

