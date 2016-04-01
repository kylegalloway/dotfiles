# Install Script
# by Kyle Galloway
# setup.sh

sudo add-apt-repository ppa:linrunner/tlp
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y \
    thermald \
    git vim cmus \
    zsh -y \
    flashplugin-installer \
    gcc g++ clang \
    python-pip python-dev build-essential \
    curl \
    silversearcher-ag \
    htop \
    tudu \
    terminator \
    qalc \
    cloc \
    sublime-text-installer \
    /

