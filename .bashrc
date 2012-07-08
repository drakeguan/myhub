# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# locale encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if [ -d ${HOME}/bin ]; then
    export PATH="${HOME}/bin:${PATH}"
fi

export LANG=en_US.UTF-8

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000 # the bash history should save 3000 commands

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK         # Do not want my shell to warn me of incoming mail.

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    ;;
xterm)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\A/$? \[\033[01;32m\][\u@\h] \[\033[01;34m\]\w$(__git_ps1 " (%s)") \$ \[\033[00m\]'
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# Define your own aliases here ...
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

################### For RenderMan #########################

# slim's external editor
export WINEDITOR=gvim
# ref: https://renderman.pixar.com/forum/showthread.php?s=&threadid=12158
# set output RIB's precision for ASCII RIB and catrib a BINARY RIB
# the default is 6
export RIPRECISION=10

# For colourful man pages (CLUG-Wiki style)
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'





#################################################

# proxy
ping -c 2 proxy.digimax.com.tw &> /dev/null
if [ $? = 0 ]
then
    export http_proxy='http://proxy.digimax.com.tw:8080'
    export https_proxy='http://proxy.digimax.com.tw:8080'
    export ftp_proxy='http://proxy.digimax.com.tw:8080'
fi

# git on drakeguan.org
if [ -d ~/git/bin ]; then
    export GIT_HOME=${HOME}/git
    export PATH=${GIT_HOME}/bin:${GIT_HOME}/lib/libexec/git-core/:${PATH}
fi

# Mac OS X specific stuff
if [ `uname` = 'Darwin' ]; then
    # local python path if available
    export PYTHONPATH=/usr/local/lib/python2.6/site-packages:$PYTHONPATH

    # work-around for XCode
    export ARCHFLAGS="-arch i386 -arch x86_64"

    ## gem installation path for homebrew
    #if [ -d /usr/local/gems ]; then
        #export GEM_HOME=/usr/local
    #fi

    # node path for node.js
    export NODE_PATH=/usr/local/lib/node_modules
fi

# local perl5 modules
if [ -d ${HOME}/perl5/lib/perl5 ]; then
    export PERL5LIB=${HOME}/perl5/lib/perl5:$PERL5LIB
fi

