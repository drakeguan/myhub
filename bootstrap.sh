#!/bin/bash

# Symlink all of the following files to bashrc_dispatch (after reading warnings below)
ln -sf $(pwd)/bashrc_dispatch ~/.bashrc
ln -sf $(pwd)/bashrc_dispatch ~/.bash_profile
ln -sf $(pwd)/bashrc_dispatch ~/.profile
ln -sf $(pwd)/bashrc_dispatch ~/.bash_login

# sourced at least once, and in most circumstances only once- before anything else.
ln -sf $(pwd)/.bashrc_once ~/.bashrc_once
# sourced on every bash instantiation
ln -sf $(pwd)/.bashrc_all ~/.bashrc_all
# sourced only when non-interactive / batch
ln -sf $(pwd)/.bashrc_script ~/.bashrc_script
# the one you'll probably fill up (mutually exclusive with ~/.bashrc_script)
ln -sf $(pwd)/.bashrc_interactive ~/.bashrc_interactive
# sourced only when an interactive shell is also a login.
ln -sf $(pwd)/.bashrc_login ~/.bashrc_login

# others
ln -sf $(pwd)/.ackrc ~/.ackrc
ln -sf $(pwd)/.bash_aliases ~/.bash_aliases
ln -sf $(pwd)/.emacs ~/.emacs
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.inputrc ~/.inputrc
ln -sf $(pwd)/.pylintrc ~/.pylintrc
ln -sf $(pwd)/.screenrc ~/.screenrc
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf
