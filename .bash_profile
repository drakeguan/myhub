# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm # Load RVM into a shell session *as a function*
