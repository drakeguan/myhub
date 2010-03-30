TERM=linux
export LANG=en_US.UTF-8

# ref: http://tldp.org/LDP/abs/html/sample-bashrc.html

# MacPorts Installer addition on 2008-12-24_at_23:35:44: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2008-12-24_at_23:35:44: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.


# History
export EDITOR=/usr/bin/vim
export HISTFILESIZE=3000 # the bash history should save 3000 commands
export HISTCONTROL=ignoredups #don't put duplicate lines in the history.
alias hist='history | grep $1' #Requires one input


# Define a few Color's
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color


#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

ulimit -S -c 0          # Don't want any coredumps.
set -o notify
set -o noclobber
set -o ignoreeof
#set -o nounset
#set -o xtrace          # Useful for debuging.

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



#-------------------------------------------------------------
# Shell Prompt
#-------------------------------------------------------------


if [[ "${DISPLAY%%:0*}" != "" ]]; then  
    HILIT=${RED}   # remote machine: prompt will be partly red
else
    HILIT=${CYAN}  # local machine: prompt will be partly cyan
fi

#  --> Replace instances of \W with \w in prompt functions below
#+ --> to get display of full path name.

function fastprompt()
{
    #unset PROMPT_COMMAND
    case $TERM in
        *term | rxvt )
            PS1="${HILIT}[\h]$NC \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${HILIT}[\h]$NC \W > " ;;
        *)
            PS1="[\h] \W > " ;;
    esac
}


_powerprompt()
{
    LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
}

function powerprompt()
{

    #PROMPT_COMMAND=_powerprompt
    case $TERM in
        *term | rxvt  )
            PS1="${HILIT}[\A - \$LOAD]$NC\n[\u@\h \#] \W > \
                 \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${HILIT}[\A - \$LOAD]$NC\n[\u@\h \#] \W > " ;;
        * )
            PS1="[\A - \$LOAD]\n[\u@\h \#] \W > " ;;
    esac
}

powerprompt     # This is the default prompt -- might be slow.
                # If too slow, use fastprompt instead. ...

#===============================================================
#
# ALIASES AND FUNCTIONS
#
# Arguably, some functions defined here are quite big.
# If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
#
# Many functions were taken (almost) straight from the bash-2.04
# examples.
#
#===============================================================

alias ls='ls -G'
alias ll='ls -l'
alias lh='ls -h'
alias llh='ls -lh'
alias la='ls -a'
alias lla='ls -la'

alias ipython='ipython2.5'

alias apache2ctl='sudo /opt/local/apache2/bin/apachectl'
alias mysqlstart='sudo mysqld_safe5 &'
alias mysqlstop='mysqladmin5 -u root -p shutdown'


#-------------------------------------------------------------
# tailoring 'less'
#-------------------------------------------------------------

#alias more='less'
export PAGER=less
#export LESSCHARSET='latin1'
#export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
   # Use this if lesspipe.sh exists
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'


export GREP_OPTIONS='--color=always'
export PYTHONPATH=/Users/drake/Documents/Code/python/lib:${PYTHONPATH}



# auto-launching ssh-agent on msysgit
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -A | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

