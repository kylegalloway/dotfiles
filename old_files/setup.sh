# Install Script
# by Kyle Galloway
# setup.sh
# 

DOTFILES="$HOME"/Repos/dotfiles

install_pkg() {
    echo -e "\033[1;33m Installing ${1}... \033[0m"
        if [ -n "${2}" ]; then
            sudo add-apt-repository "${2}"
            sudo apt-get update &>/dev/null
        fi
        if ! which "${1}" &>/dev/null; then
            sudo apt-get install -y "${1}" &>/dev/null
        fi
    echo -e "\033[1;33m ${1} installed... \033[0m"
}

change_shell() {
    echo -e "Changing your shell to ${1} ..."
    chsh -s "$(which "${1}")"
}

zsh_use() {
    install_pkg zsh
    change_shell zsh
}

oh_my_zsh_setup(){
    echo "installing oh-my-zsh"
    if which wget &>/dev/null; then
        wget --no-check-certificate http://install.ohmyz.sh -O - | sh
    else
        curl -L http://install.ohmyz.sh | sh
    fi
    git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME"/.oh-my-zsh
}

symlink() {
  cd "$HOME" || exit
  ORG=$1
  DST=$2
  echo "Symlinking: ${ORG} -> ${DST}"
  if [[ -f $DST ]]; then
    mv "$DST" "${DST}".bak
  fi
  rm -f "$DST"
  ln -s "$ORG" "$DST"
  cd - >/dev/null 2>&1 || exit
}

do_symlinking(){
    cd "$DOTFILES" || exit
    for f in ./.* ; do
        BASENAME=$(basename "$f")
        if [ "$BASENAME" != ".." ] || [ "$BASENAME" != "." ] || [ "$BASENAME" != ".git" ] || [ "$BASENAME" != ".gitignore" ]; then 
		symlink "$f" "${HOME}/$(basename "$f")"
	fi
    done
}

setup_repos(){
    mkdir -p "$HOME"/Repos
    git clone https://github.com/kylegalloway/dotfiles.git "$HOME"/Repos/dotfiles
    git clone  https://github.com/simonwhitaker/gibo "$HOME"/Repos/gibo
}

dotfile_setup(){
    cd "$DOTFILES" || exit
    for f in ./.* ; do
        BASENAME=$(basename "$f")
        if [ "$BASENAME" != ".." ] || [ "$BASENAME" != "." ] || [ "$BASENAME" != ".git" ] || [ "$BASENAME" != ".gitignore" ]; then 
		cp "$f" "${HOME}/$(basename "$f")"
	fi
    done
}

basic_setup() {
    echo -e "\033[1;30m- running basic setup..."
     sudo apt-get update &>/dev/null
     install_pkg git
#     install_pkg tlp ppa:linrunner/tlp
#     install_pkg xorg
#     install_pkg network-manager
#     install_pkg wireless-tools
#     install_pkg wpasupplicant
#     install_pkg alsa-base
#     install_pkg volumeicon-alsa
#     install_pkg suckless-tools
#     install_pkg hal
#     install_pkg acpi
#     install_pkg spectrwm
#     install_pkg conky-cli
#     install_pkg thermald
     install_pkg vim
#     install_pkg rxvt-unicode-256color
#     install_pkg surf
#     install_pkg gcc
#     install_pkg g++
#     install_pkg clang
#     install_pkg curl
#     install_pkg cmus
#     install_pkg htop
#     install_pkg silversearcher-ag
#     install_pkg tudu
#     install_pkg cloc
#     install_pkg tty-clock
#     install_pkg feh
#     install_pkg rtorrent
#     install_pkg xscreensaver
#     install_pkg python-pip
#     install_pkg python-dev
#     install_pkg build-essential
     zsh_use
#     oh_my_zsh_setup
#     setup_repos
#     do_symlinking
#     dotfile_setup
    echo -e "\033[1;30m- Done!!..."
}

basic_setup
