# some more ls aliases
alias ll='ls -l'
alias llh='ls -lh'
alias lh='ls -lh'
alias lla='ls -la'
alias la='ls -A'
alias l='ls -CF'

alias bc='bc -l'
alias cpaf='cp --no-dereference -R --preserve=mode,link'

# grep
MACHINE=`uname -m`
UBUNTUVERSION=`cat /etc/issue | grep Ubuntu | cut -d " " -f 2`      # 6.06.2, 7.10
if [ $UBUNTUVERSION == "7.10" ]; then
    alias grep='grep --exclude="*svn*"'
else
    alias grep='grep --exclude-dir=".svn"'
fi
alias cgrep='grep --color'
alias dgrep='grep -rIn --exclude="*svn*" --exclude="*Po" --exclude="Makefile*" '

alias xine='xine -l'
alias eric='PYTHONPATH=/usr/lib/python2.5/site-packages/:${PYTHONPATH} eric'
alias ps='ps auxf'
alias du1='du -h --max-depth=1'

# svn 
alias svnmeld='svn diff --diff-cmd "/usr/bin/meld"'
alias svndiff='svn diff -x -b'
function svnmeld2() { svn diff --diff-cmd "/usr/bin/meld" --old=$1@$2 --new=$1@$3 ;}

# Vim 6 doesn't support "-p"!
VIMVERSION=`vim --version 2>&1 | grep "Vi IMproved 6"`
if [ -z "${VIMVERSION}" ]; then
    alias vim='vim -p'
    alias gvim='gvim -p'
fi


