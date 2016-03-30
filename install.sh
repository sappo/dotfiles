#!/bin/bash

function install_symlink
{
    if [ ! -e $HOME/$2 ]; then
        cd $HOME
        ln -s $1/$2 $2
        cd -
        echo "Installed symlink for $2";
    else
        echo "Symlink for $2 already exists";
    fi
}

PS3='Please choose which dotfiles to install: '
options=("tmux" "vim" "git" "all" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "tmux")
            install_symlink $PWD .tmux.conf
            install_symlink $PWD .tmuxline
            ;;
        "vim")
            install_symlink $PWD .vimrc
            ;;
        "git")
            install_symlink $PWD .gitconfig
            ;;
        "all")
            install_symlink $PWD .tmux.conf
            install_symlink $PWD .tmuxline
            install_symlink $PWD .vimrc
            install_symlink $PWD .gitconfig
            break
            ;;
        "quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
