# Install Script
# by Kyle Galloway
# setup-repos.sh

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y git
git config --global push.default simple
mkdir -p ~/Repos
git clone https://github.com/kylegalloway/dotfiles.git ~/Repos/dotfiles
git clone  https://github.com/simonwhitaker/gibo ~/Repos/gibo
