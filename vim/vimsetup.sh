#!/bin/sh -x
set -e

if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc-bak
fi
wget -qO ~/.vimrc http://confile.googlecode.com/svn/trunk/vim/.vimrc


# compile vim from source:
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
cd ~
mkdir -p source
cd source
hg clone https://code.google.com/p/vim/
cd vim
./configure --with-features=huge \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7-config \
            --enable-luainterp \
            --enable-perlinterp \
            --disable-gui --enable-cscope --prefix=/usr

# vim74 is found from vim/README.txt
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install


# install vundle:
# https://github.com/gmarik/vundle#about
cd ~
if [ -e ~/.vim ]; then
    mv ~/.vim ~/.vim-bak
fi
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
