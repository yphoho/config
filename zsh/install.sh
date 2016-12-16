#!/bin/sh -x
set -e
set -u


sudo aptitude install zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

mv ~/.zshrc ~/.zshrc.orig || true
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh

git clone git://github.com/joelthelion/autojump.git
cd autojump
sudo ./install.py

# Please manually add the following line(s) to ~/.zshrc:
#
#     [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
#
#     autoload -U compinit && compinit -u
#
# Please restart terminal(s) before running autojump.
