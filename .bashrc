# Load system bash configurations
if [ -f /etc/bashrc ]; then
    . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

###############
# Completions #
###############

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if command_exists kubectl; then
    source <(kubectl completion bash)
fi

if command_exists helm; then
    source <(helm completion bash)
fi

####################
# Common functions #
####################

command_exists ()
{
    hash "$1" 2> /dev/null;
}

##########
# Colors #
##########

# Upgrade xterm session to use colors.
# This will make tmux display the correct colors.
TERMINFO_LOCATIONS=(${HOME}/.terminfo /etc/terminfo /lib/terminfo /usr/share/terminfo)
if [ "$TERM" = "xterm" ]; then
    for terminfo in ${TERMINFO_LOCATIONS[@]}; do
        if [ -e $terminfo/x/xterm-256color ]; then
            export TERM=xterm-256color
            break
        elif [ -e $terminfo/x/xterm-color ]; then
            export TERM=xterm-color
            break
        fi
    done
fi
if [ "$TERM" = "screen" ]; then
    for terminfo in ${TERMINFO_LOCATIONS[@]}; do
        if [ -e $terminfo/s/screen-256color ]; then
            export TERM=screen-256color
        fi
    done
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lha'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Get color support for 'less'
export LESSOPEN="|~/.lesspipe.sh %s"
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

##############
# Networking #
##############

#  To set a my_proxy permanently add the file ~/.bash_proxy and insert your
#  proxy url.

function my_proxy()
{
    proxy_url=$1
    export  http_proxy="$proxy_url"
    export https_proxy="$proxy_url"
    export   ftp_proxy="$proxy_url"
}

function my_noproxy()
{
    export http_proxy=""
    export https_proxy=""
    export ftp_proxy=""
}

if [ -f ~/.bash_proxy ]; then
    my_proxy $(head -n 1 ~/.bash_proxy)
else
    my_noproxy
fi


#########
# Paths #
#########

# user space haskell packages
if command_exists cabal; then
    if [ -d ~/.cabal ]; then
        export PATH=$HOME/.cabal/bin:$PATH
    fi
fi

# user space npm packages
if command_exists npm; then
    export NPM_CONFIG_PREFIX=$HOME/.npm
    export PATH=$HOME/.npm/bin:$PATH
fi

# user space perl packages
if command_exists cpan; then
    if [ -d ~/perl5 ]; then
        PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
        PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
        PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
        PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
        PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
    fi
fi

# user space python packages
if [ -d ~/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi
if [ -d $HOME/miniconda3/bin/ ]; then
    export PATH=$PATH:$HOME/miniconda3/bin/
fi

# python virtualenv
if command_exists activate.sh; then
    source `which activate.sh`
fi

if command_exists virtualenvwrapper.sh; then
    source virtualenvwrapper.sh
fi

# user space go packages
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

###########
# Aliases #
###########

# copy a stream in the X clipboard, e.g. "cat file | xcopy"
alias xcopy="xclip -i -selection clipboard"
# downgrade terminal to xterm in case the remote does not support colors
alias ssh='TERM=xterm ssh'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

###########
# History #
###########

# do not permits to recall dangerous commands in bash history
export HISTIGNORE='&:[bf]g:exit:*>|*:*rm*-rf*:*rm*-f*'
# append history rather than overwrite
shopt -s histappend
# one command per line
shopt -s cmdhist
unset HISTFILESIZE
HISTSIZE=1000000
# ignore commands that start with a space AND duplicate commands
HISTCONTROL=ignoreboth
# add the full date and time to lines
HISTTIMEFORMAT='%F %T '

#########
# Other #
#########

# Use liquidprompt only if in an interactive shell
if [[ $- == *i* ]]; then
    ## Super nice prompt
    . ~/.liquidpromptrc
    . ~/.liquidprompt
fi

###########
# Exports #
###########

# Set default EDITOR
export VISUAL=vim
export EDITOR="$VISUAL"

if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

##########
# Checks #
##########

# OpenPGP applet support for YubiKey NEO
if command_exists gpg-agent; then
    if [ ! -f /tmp/gpg-agent.env ]; then
        killall gpg-agent;
        eval $(gpg-agent --daemon --enable-ssh-support > /tmp/gpg-agent.env);
    fi
    . /tmp/gpg-agent.env
fi

GPG_TTY=$(tty)
export GPG_TTY

#  Check if there are updates for the dotfiles on a tracked master branch
#  Only check once after each reboot, for performance reasons!
if [ ! -f /tmp/bashrc_check ]; then
    echo Checking for dotfiles updates ...
    cd $(dirname $(readlink -e ~/.bashrc))
    timeout 5s git fetch --quiet --all
    if [ $? = 0 ]; then
        for remote in $(git remote show);
        do
            for branch in $(git branch --all --list);
            do
                if [[ $branch == *"${remote}/HEAD" ]]; then # true if tracking
                    if [[ ! $(git rev-parse HEAD) == $(git rev-parse $remote/master) ]]; then
                        echo $(git rev-list HEAD...$remote/master --count)" new updates available for dotfiles from ${remote}/master!"
                    fi
                fi
            done
        done
        touch /tmp/bashrc_check
    else
        echo Timeout! Try again later.
    fi
    cd - 2>&1 >/dev/null
fi

# added by travis gem
[ -f /home/sappo/.travis/travis.sh ] && source /home/sappo/.travis/travis.sh
# Fixes alt+(left/right) behaviour and prevents tty switching
alias ttyfix=sudo sh -c 'dumpkeys -k|grep -v Incr_Console|grep -v Decr_Console|grep -v Last_Console|loadkeys'
