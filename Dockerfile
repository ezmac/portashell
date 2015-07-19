FROM debian
MAINTAINER Tad Merchant <system.root@gmail.com>

## INSTALL SOFTWARE 

# do dist upgrade to be on latest debian.
ADD sources.list /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

# install incron and supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl zsh git tmux

# thanks valloric
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source#
ADD installVim.sh /root/

RUN DEBIAN_FRONTEND=noninteractive chmod u+x /root/installVim.sh
RUN DEBIAN_FRONTEND=noninteractive /root/installVim.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo

RUN adduser --disabled-password --gecos '' tad && adduser tad sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#haha curltobash...


USER tad
RUN DEBIAN_FRONTEND=noninteractive sudo chsh -s $(which zsh)

RUN DEBIAN_FRONTEND=noninteractive cd /home/tad && curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | /bin/bash
ADD ohmyzsh.sh /home/tad/.ohmyzsh.sh

RUN DEBIAN_FRONTEND=noninteractive cd /home/tad && sudo chmod +x .ohmyzsh.sh; sync && ./.ohmyzsh.sh

RUN DEBIAN_FRONTEND=noninteractive cd /home/tad && git clone https://github.com/ezmac/dotfiles.git .dotfiles
ADD linkDotfiles.sh /home/tad/.linkDotfiles.sh
RUN DEBIAN_FRONTEND=noninteractive cd /home/tad/  && chmod +x .linkDotfiles.sh; sync && ./.linkDotfiles.sh
WORKDIR /home/tad



CMD ["/bin/zsh"]



