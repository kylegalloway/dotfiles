#! /usr/bin/zsh
# Uninstall Script
# by Kyle Galloway
# cleanup.sh
# Uncomment the command below to see the commands that are being run (prefaced with `+`)
# set -x

DOTFILES="$HOME"/Repos/dotfiles/files


uninstall_emacs() {
    uninstall_pkg emacs26 ppa:kelleyk/emacs
    emacs_dir=${HOME}/.emacs.d
    rm -rf ${emacs_dir}
    unlink "$DOTFILES"/init.el ${emacs_dir}/init.el
}

uninstall_nms() {
    echo -e "\033[1;33m Uninstalling No More Secrets \033[0m"
    rm -rf ~/src
    rm -rf ~/src/no-more-secrets
}

remove_fun_tools() {
    # No More Secrets (Sneakers movie effect)
    uninstall_nms
    uninstall_pkg oneko
    uninstall_pkg cmatrix
    uninstall_pkg libaa-bin
    uninstall_pkg asciiquarium ppa:ytvwld/asciiquarium
}

uninstall_fzf() {
    echo -e "\033[1;33m Uninstalling FZF \033[0m"
    rm -rf ~/.fzf
}

uninstall_autojump() {
    echo -e "\033[1;33m Uninstalling autojump \033[0m"
    rm -rf ~/src
    rm -rf ~/src/autojump
}

uninstall_ripgrep() {
    echo -e "\033[1;33m Uninstalling ripgrep \033[0m"
    uninstall_pkg ripgrep
}

uninstall_bat() {
    echo -e "\033[1;33m Uninstalling bat \033[0m"
    uninstall_pkg bat
}

uninstall_fd() {
    echo -e "\033[1;33m Uninstalling fd \033[0m"
    uninstall_pkg fd-find
}

remove_faster_tools() {
    # fzf
    uninstall_fzf

    # autojump
    uninstall_autojump

    # ripgrep
    uninstall_ripgrep

    # bat
    uninstall_bat

    # fd
    uninstall_fd

    # ranger
    uninstall_pkg ranger
}

vundle_uninstall() {
   vim +PluginRemove +qall
   rm -rf ~/.vim/bundle/Vundle.vim
}

uninstall_pkg() {
    echo -e "\033[1;33m Uninstalling ${1}... \033[0m"
    sudo apt-get purge -y "${1}" &>/dev/null
    if [ -n "${2}" ]; then
        sudo add-apt-repository --remove "${2}"
        sudo apt-get update &>/dev/null
    fi
    echo -e "\033[1;33m ${1} uninstalled... \033[0m"
}

conky_cleanup() {
   echo "Uninstalling conky"
   conky_dir=${HOME}/.config/conky
   rm -rf ${conky_dir}
   unlink "$DOTFILES"/conky/conky.conf ${conky_dir}
}

conky_use() {
   uninstall_pkg conky
   uninstall_pkg fonts-font-awesome
   conky_cleanup
}

uninstall_fonts() {
    uninstall_pkg fonts-powerline
    python ./uninstallFonts.py
}

unlink() {
  cd "$HOME" || exit
  ORG=$1
  DST=$2
  echo "Unlinking: ${ORG} -> ${DST}"
  if [[ -f $DST ]]; then
    rm -f "$DST" "${DST}".bak
  fi
  rm -f "$DST"
  cd - >/dev/null 2>&1 || exit
}

do_unlinking(){
    cd "$DOTFILES" || exit
    for f in ./.* ; do
        BASENAME=$(basename "$f")
        if [ "$BASENAME" != ".." ] || [ "$BASENAME" != "." ] || [ "$BASENAME" != ".git" ] || [ "$BASENAME" != ".gitignore" ]; then 
           unlink $(readlink -e "$f") "${HOME}/${BASENAME}"
        fi
    done
    rm -f $DOTFILES/prompt_kgalloway_setup $HOME/.zprezto/modules/prompt/functions/prompt_kgalloway_setup
}

basic_cleanup() {
    echo -e "\033[1;30m- running basic cleanup..."
    sudo apt-get update &>/dev/null
    uninstall_pkg git
    uninstall_pkg vim
    uninstall_pkg caffeine
    uninstall_fonts
    vundle_uninstall
    uninstall_pkg zsh
    conky_use
    do_unlinking
    remove_faster_tools
    remove_fun_tools
    uninstall_emacs
    echo -e "\033[1;30m- Done!!..."
}

basic_cleanup

