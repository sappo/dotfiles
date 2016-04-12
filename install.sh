#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
STD='\e[39m'

# Prints out the relative path between to absolute paths. Trivial.
#
# Parameters:
# $1 = first path
# $2 = second path
#
# Output: the relative path between 1st and 2nd paths
relpath() {
    local pos="${1%%/}" ref="${2%%/}" down=''

    while :; do
        test "$pos" = '/' && break
        case "$ref" in $pos/*) break;; esac
        down="../$down"
        pos=${pos%/*}
    done

    echo "$down${ref##$pos/}"
}

install_symlink () {
    if [ -z "$3" ]; then
        LINK_NAME=$2
    else
        LINK_NAME=$3
    fi

    if [ ! -e $HOME/$LINK_NAME ] && [ ! -d $HOME/$LINK_NAME ]; then
        cd $HOME
        ln -s "$(relpath "$PWD" "$1")"/$2 $3
        cd -
        echo "Installed symlink for $2";
    else
        echo "Symlink for $2 already exists";
    fi
}

install_tmux () {
    if [ ! -e $HOME/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    install_symlink $PWD .tmux.conf
    install_symlink $PWD .tmuxline
}

is_tmux_installed () {
    if [ -e $HOME/.tmux.conf ] || [ -d $HOME/.tmux.conf ]; then
        echo "installed"
    fi
}

install_vim () {
    install_symlink $PWD .vimrc
}

is_vim_installed () {
    if [ -e $HOME/.vimrc ] || [ -d $HOME/.vimrc ]; then
        echo "installed"
    fi
}

install_git () {
    install_symlink $PWD .gitconfig
}

is_git_installed () {
    if [ -e $HOME/.gitconfig ] || [ -d $HOME/.gitconfig ]; then
        echo "installed"
    fi
}

install_bash () {
    install_symlink $PWD .bashrc
    install_symlink $PWD .liquidpromptrc
    install_symlink $PWD .LESS_TERMCAP
    git submodule update --init --remote
    install_symlink $PWD liquidprompt/liquidprompt .liquidprompt
    if ! type "source-highlight" >/dev/null 2>&1; then
        if type "apt-get" >/dev/null 2>&1; then
            echo "Insert your password to install source-highlight for less:"
            sudo apt-get --assume-yes install source-highlight 2>&1 >/dev/null
            echo "Installed source-highlight for less"
        fi
        if type "pacman" >/dev/null 2>&1; then
            echo "Insert your password to install source-highlight for less:"
            sudo pacman -S source-highlight 2>&1 >/dev/null
            echo "Installed source-highlight for less"
        fi
    fi
}

is_bash_installed () {
    if [ -e $HOME/.bashrc ] &&
       [ -e $HOME/.liquidpromptrc ] &&
       [ -e $HOME/.LESS_TERMCAP ]; then
        echo "installed"
    fi
}

while :
do
    clear
    cat<<EOF
    =====================================
    Sappo's dotfile installer
    -------------------------------------
    Please enter which dotfile to install

    all         (1)
    bashrc      (2) - $(is_bash_installed)
    gitconfig   (3) - $(is_git_installed)
    vimrc       (4) - $(is_vim_installed)
    tmux        (5) - $(is_tmux_installed)
                (Q)uit
    -------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")
        install_tmux
        install_git
        install_vim
        install_bash
        ;;
    "2")
        install_bash
        ;;
    "3")
        install_git
        ;;
    "4")
        install_vim
        ;;
    "5")
        install_tmux
        ;;
    "q")  exit                      ;;
    "Q")  exit                      ;;
     * )  echo -e "${RED}invalid option...${STD}";;
    esac
    read -p "Press [Enter] key to continue..." fackEnterKey
done
