# Install Script
# by Kyle Galloway
# setup-pip_zsh.sh

echo "PIP"
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv
sudo pip install Flask pycrypto livestreamer term2048 jrnl

echo "ZSH"
sudo chsh -s $(which zsh) && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"