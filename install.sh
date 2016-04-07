#!/bin/bash

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

function install_symlink
{
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

install_vim () {
    install_symlink $PWD .vimrc
}

install_git () {
    install_symlink $PWD .gitconfig
}

install_bash () {
    install_symlink $PWD .bashrc
    install_symlink $PWD .liquidpromptrc
    git submodule update --init --remote
    install_symlink $PWD liquidprompt/liquidprompt .liquidprompt
}

PS3='Please choose which dotfiles to install: '
options=("tmux" "vim" "git" "bashrc" "all" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "tmux")
            install_tmux
            ;;
        "vim")
            install_vim
            ;;
        "git")
            install_git
            ;;
        "bashrc")
            install_bash
            ;;
        "all")
            install_tmux
            install_git
            install_vim
            install_bash
            break
            ;;
        "quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
