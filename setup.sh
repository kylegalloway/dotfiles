#! /usr/bin/zsh
# Install Script
# by Kyle Galloway
# setup.sh
# Uncomment the command below to see the commands that are being run (prefaced with `+`)
# set -x

DOTFILES="$HOME"/Repos/dotfiles/files


install_nms() {
    echo -e "\033[1;33m Installing No More Secrets \033[0m"
    if ! nms_loc="$(type -p "nms")" || [[ -z $nms_loc ]]; then
        mkdir -p ~/src
        git clone https://github.com/bartobri/no-more-secrets.git ~/src/no-more-secrets
        cd ~/src/no-more-secrets
        make nms
        make sneakers             ## Optional
        sudo make install
    fi
}

get_fun_tools() {
    # No More Secrets (Sneakers movie effect)
    install_nms
}

install_fzf() {
    echo -e "\033[1;33m Installing FZF \033[0m"
    if ! fzf_loc="$(type -p "fzf")" || [[ -z $fzf_loc ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    else
        echo -e "\033[1;33m FZF is already installed \033[0m"
    fi
}

install_autojump() {
    echo -e "\033[1;33m Installing autojump \033[0m"
    if ! autojump_loc="$(type -p "autojump")" || [[ -z $autojump_loc ]]; then
        mkdir -p ~/src
        git clone git://github.com/wting/autojump.git ~/src/autojump
        cd ~/src/autojump
        python ./install.py
    else
        echo -e "\033[1;33m autojump is already installed \033[0m"
    fi
}

install_ripgrep() {
    echo -e "\033[1;33m Installing ripgrep \033[0m"
    if [ $(echo "$DISTRIB_RELEASE > 18.10" |bc -l); then
        install_pkg ripgrep
    else
        if ! ripgrep_loc="$(type -p "rg")" || [[ -z $ripgrep_loc ]]; then
            curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
            sudo dpkg -i ./ripgrep_11.0.2_amd64.deb
        else
            echo -e "\033[1;33m ripgrep is already installed \033[0m"
        fi
    fi
}

install_bat() {
    echo -e "\033[1;33m Installing bat \033[0m"
    if ! bat_loc="$(type -p "bat")" || [[ -z $bat_loc ]]; then
        curl -LO https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
        sudo dpkg -i ./bat_0.11.0_amd64.deb
    else
        echo -e "\033[1;33m bat is already installed \033[0m"
    fi
}

install_fd() {
    echo -e "\033[1;33m Installing fd \033[0m"
    if [ $(echo "$DISTRIB_RELEASE > 19.04" |bc -l); then
        install_pkg fd-find
    else
        if ! fd_loc="$(type -p "fd")" || [[ -z $fd_loc ]]; then
            curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb
            sudo dpkg -i ./fd_7.3.0_amd64.deb
        else
            echo -e "\033[1;33m fd is already installed \033[0m"
        fi
    fi
}

get_faster_tools() {
    # Source lsb-release so $DISTRIB_RELEASE is defined
    . /etc/lsb-release

    # fzf
    install_fzf

    # autojump
    install_autojump

    # ripgrep
    install_ripgrep

    # bat
    install_bat

    # fd
    install_fd

    # ranger
    install_pkg ranger
}

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
    if ! foobar_loc="$(type -p "${1}")" || [[ -z $foobar_loc ]]; then
        echo -e "\033[1;33m Installing ${1}... \033[0m"
        if [ -n "${2}" ]; then
            sudo add-apt-repository "${2}"
            sudo apt-get update &>/dev/null
        fi
        sudo apt-get install -y "${1}" &>/dev/null
        echo -e "\033[1;33m ${1} installed... \033[0m"
    else
        echo -e "\033[1;33m ranger is already installed \033[0m"
    fi
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
    # sudo apt-get update &>/dev/null
    # install_pkg git
    # install_pkg vim
    # install_pkg caffeine
    # install_fonts
    # get_dotfiles
    # vundle_install
    # zsh_use
    # conky_use
    # do_symlinking
    get_faster_tools
    get_fun_tools
    echo -e "\033[1;30m- Done!!..."
}

basic_setup

