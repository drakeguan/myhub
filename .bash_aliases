OS=$(uname)
## some more ls aliases
if [ "$TERM" != "dumb" ]; then
    if [ $OS = "Darwin" ]; then
	alias ls='ls -G'
    else
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
    fi
    alias dir='ls --format=vertical'
    alias vdir='ls --format=long'
fi

alias ll='ls -l'
alias llh='ls -lh'
alias lh='ls -lh'
alias lla='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias lrt='ls -lrt'

alias bc='bc -l'
alias cpaf='cp --no-dereference -R --preserve=mode,link'
#alias ssh='ssh -X'

# grep
#MACHINE=`uname -m`
if [ -f /etc/issue ]; then
    UBUNTUVERSION=`cat /etc/issue | grep Ubuntu | cut -d " " -f 2`
    if [ "$UBUNTUVERSION" = "7.10" ]; then
	alias grep='grep --exclude="*svn*"'
    else
	alias grep='grep --exclude-dir=".svn"'
    fi
    alias cgrep='grep --color'
    alias dgrep='grep -rIn --exclude="*svn*" --exclude="*Po" --exclude="Makefile*" '
fi

alias xine='xine -l'
#alias eric='PYTHONPATH=/usr/lib/python2.5/site-packages/:${PYTHONPATH} eric'
if [ $OS = "Darwin" ]; then
    alias ps='ps aux'
    alias top='top -o cpu'
else
    alias ps='ps auxf'
fi
alias du1='du -h --max-depth=1'

# svn 
alias svnmeld='svn diff --diff-cmd "/usr/bin/meld"'
alias svndiff='svn diff -x -b'
function svnmeld2() { svn diff --diff-cmd "/usr/bin/meld" --old=$1@$2 --new=$1@$3 ;}

# couchdb
alias jj='python -mjson.tool'

# Vim 6 doesn't support "-p"!
VIMVERSION=`vim --version 2>&1 | grep "Vi IMproved 6"`
if [ -z "${VIMVERSION}" ]; then
    alias vim='vim -p'
    alias gvim='gvim -p'
fi

function mkcd() { mkdir -p $@; cd $@; }

# private alias
if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

###########
# git
alias g='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit -am'
alias gb='git branch'
alias gbd='git branch -d'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias gl='git log'
alias gs='git show'
alias gd='git diff'
alias gbl='git blame'
alias gps='git push'
alias gpl='git pull'

# vim: set ft=sh:
