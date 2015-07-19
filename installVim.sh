#!/bin/bash
## Adapted slightly from valloric's script. See dockerfile

#Compiling Vim from source is actually not that difficult. Here's what you should do:

#First, install all the prerequisite libraries, including Mercurial. For a Debian-like Linux distribution like Ubuntu, that would be the following:

apt-get install -t libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial

#Remove vim if you have it already.

apt-get remove vim vim-runtime gvim

#On Ubuntu 12.04.2 you probably have to remove these packages as well:

 apt-get remove vim-tiny vim-common vim-gui-common
#Once everything is installed, getting the source is easy. If you're not using vim 7.4, make sure to set the VIMRUNTIMEDIR variable correctly below (for instance, with vim 7.4a, use /usr/share/vim/vim74a):

cd ~
hg clone https://code.google.com/p/vim/
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim74
 make install
# If you want to be able to easily uninstall the package use checkinstall instead of  make install

 apt-get install checkinstall
cd vim
 checkinstall
Set vim as your default editor with update-alternatives.

 update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
 update-alternatives --set editor /usr/bin/vim
 update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
 update-alternatives --set vi /usr/bin/vim
