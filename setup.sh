#! /usr/bin/zsh
# Install Script
# by Kyle Galloway
# setup.sh
# 

DOTFILES="$HOME"/Repos/dotfiles/files

vundle_install() {
   git_clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim +PluginInstall +qall
}

git_clone() {
    install_pkg git
    echo -e "\033[1;33m Cloning ${1}... \033[0m"
        if [ -n "${2}" ]; then
            git clone ${1} ${2}
	else
	    git clone ${1}
        fi
    echo -e "\033[1;33m ${1} installed... \033[0m"
}

get_dotfiles() {
   mkdir -p $HOME/Repos
    git_clone https://github.com/kylegalloway/dotfiles $HOME/Repos/dotfiles
}

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

conky_setup() {
   echo "Installing conky"
   conky_dir=${HOME}/.config/conky
   mkdir -p ${conky_dir}
   symlink "$DOTFILES"/conky/conky.conf ${conky_dir}
}

conky_use() {
   install_pkg conky
   install_pkg fonts-font-awesome
   conky_setup
}

install_fonts() {
    install_pkg fonts-powerline
    python ./installFonts.py
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
           symlink $(readlink -e "$f") "${HOME}/${BASENAME}"
        fi
    done
    ln -sf $DOTFILES/prompt_kgalloway_setup $HOME/.zprezto/modules/prompt/functions/prompt_kgalloway_setup
}

basic_setup() {
    echo -e "\033[1;30m- running basic setup..."
    sudo apt-get update &>/dev/null
    install_pkg git
    install_pkg vim
    install_pkg caffeine
    install_fonts
    get_dotfiles
    vundle_install
    zsh_use
    conky_use
    do_symlinking
    echo -e "\033[1;30m- Done!!..."
}

basic_setup

