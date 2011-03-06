# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# locale encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# MacPorts Installer addition on 2008-12-24_at_23:35:44: adding an appropriate PATH variable for use with MacPorts.
if [ -d /opt/local/bin ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi
# Finished adapting your PATH environment variable for use with MacPorts.
if [ -d ${HOME}/bin ]; then
    export PATH="${HOME}/bin/:${PATH}"
fi

# MacPorts Installer addition on 2008-12-24_at_23:35:44: adding an appropriate MANPATH variable for use with MacPorts.
if [ -d /opt/local/share/man ]; then
    export MANPATH=/opt/local/share/man:$MANPATH
fi
# Finished adapting your MANPATH environment variable for use with MacPorts.

export LANG=en_US.UTF-8

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000 # the bash history should save 3000 commands

shopt -s checkwinsize
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
xterm)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}\A/$? \[\033[01;32m\][\u@\h] \[\033[01;34m\]\w \$ \[\033[00m\]'
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# git on drakeguan.org
if [ -d ~/git/bin ]; then
    export GIT_HOME=${HOME}/git
    export PATH=${GIT_HOME}/bin:${GIT_HOME}/lib/libexec/git-core/:${PATH}
fi

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
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
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


#export LD_LIBRARY_PATH=/opt/pixar/RenderMan_Studio-1.0.1-Maya8.5/bin/:/shows/dgTools/bin/64bit

ping -c 2 proxy.digimax.com.tw &> /dev/null
if [ $? = 0 ]
then
    export http_proxy='http://proxy.digimax.com.tw:8080'
    export https_proxy='http://proxy.digimax.com.tw:8080'
    export ftp_proxy='http://proxy.digimax.com.tw:8080'
fi

# local python path if available
if [ -d ${HOME}/Documents/Code/python/lib ]; then
    export PYTHONPATH=${HOME}/Documents/Code/python/lib:${PYTHONPATH}
fi

# local perl5 modules
if [ -d ${HOME}/perl5/lib/perl5 ]; then
    export PERL5LIB=${HOME}/perl5/lib/perl5:$PERL5LIB
fi
