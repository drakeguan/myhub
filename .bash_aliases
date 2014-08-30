# vim: set ft=sh:

# Author.: Ole J
# Date...: 23.03.2008
# License: Whatever

# Wraps a completion function
# make-completion-wrapper <actual completion function> <name of new func.>
#                         <command name> <list supplied arguments>
# eg.
# 	alias agi='apt-get install'
# 	make-completion-wrapper _apt_get _apt_get_install apt-get install
# defines a function called _apt_get_install (that's $2) that will complete
# the 'agi' alias. (complete -F _apt_get_install agi)
#
function make-completion-wrapper () {
	local function_name="$2"
	local arg_count=$(($#-3))
	local comp_function_name="$1"
	shift 2
	local function="
function $function_name {
	((COMP_CWORD+=$arg_count))
	COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
	"$comp_function_name"
	return 0
}"
	eval "$function"
	#echo $function_name
	#echo "$function"
}


if shell_is_osx; then
	alias ls='ls -G'
	alias ps='ps aux'
	alias top='top -o cpu'
	alias ldd='otool -L'
else
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
	alias ps='ps auxf'
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
alias grant='eval `ssh-agent -s` && ssh-add'

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
alias du1='du -h --max-depth=1'
alias dush='du -sh'

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

#~/complete -p git
#complete -o bashdefault -o default -o nospace -F _git git

alias g='git status'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'
alias gc='git commit -m'
alias gca='git commit -am'
alias gb='git branch'
make-completion-wrapper _git _git_gb git branch
complete -o bashdefault -o default -o nospace -F _git_gb gb
alias gba='git branch -a'
alias gbr='git branch -r'
alias gbd='git branch -d'
make-completion-wrapper _git _git_gbd git branch -d
complete -o bashdefault -o default -o nospace -F _git_gbd gbd
alias gco='git checkout'
make-completion-wrapper _git _git_gco git checkout
complete -o bashdefault -o default -o nospace -F _git_gco gco
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias gds='git diff --stat'
alias gdsd='git diff --stat `gmbd`'
alias gg='git log --graph --decorate --oneline'
alias gm='git merge'
alias gmb='git merge-base `gn`'
alias gmbd='git merge-base `gn` develop'
alias gn='git name-rev --name-only HEAD'
alias gr='git rebase'
alias gl='git log'
make-completion-wrapper _git _git_gl git log
complete -o bashdefault -o default -o nospace -F _git_gl gl
alias glp='git log --pretty=format:"%h %s" --graph'
alias glg='git log --graph'
alias glg2="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git show'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdm='git difftool -t meld'
alias gbl='git blame'
alias gps='git push'
alias gpl='git pull'
alias gt='git tag'

# gpg
alias gpgget='gpg --keyserver keyserver.ubuntu.com --recv-keys'
alias gpgput='gpg --epoxrt --armor'

# wget
alias wget-mirror='wget --mirror --page-requisites --no-parent -c'

# AV related
alias dgffprobe='ffprobe -v quiet -show_format -show_streams -print_format json -i'

# AWS CLI
if [ -f /usr/local/bin/aws_completer ]; then
    complete -C aws_completer aws
fi
