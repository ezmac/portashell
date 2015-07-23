FROM debian:latest
MAINTAINER Tad Merchant <system.root@gmail.com>

## INSTALL SOFTWARE 

# do dist upgrade to be on latest debian.
ADD sources.list /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -f

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  wget 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  curl 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  zsh 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  git 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  tmux

# thanks valloric
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source#
ADD installVim.sh /root/

RUN DEBIAN_FRONTEND=noninteractive chmod u+x /root/installVim.sh
RUN DEBIAN_FRONTEND=noninteractive /root/installVim.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo ruby cmake

RUN DEBIAN_FRONTEND=noninteractive wget -qO- https://get.docker.com/ | sh

RUN adduser --disabled-password --gecos '' tad && adduser tad sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN usermod -aG docker tad




USER tad
RUN DEBIAN_FRONTEND=noninteractive sudo chsh -s $(which zsh)

RUN DEBIAN_FRONTEND=noninteractive cd /home/tad && curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | /bin/bash
ADD ohmyzsh.sh /home/tad/.ohmyzsh.sh

RUN DEBIAN_FRONTEND=noninteractive cd /home/tad && sudo chmod +x .ohmyzsh.sh; sync && ./.ohmyzsh.sh

RUN DEBIAN_FRONTEND=noninteractive cd /home/tad && git clone https://github.com/ezmac/dotfiles.git .dotfiles && cd .dotfiles&&git checkout mac && ./linkDotfiles.sh

WORKDIR /home/tad

ENV TERM xterm


ADD init.sh /home/tad/.init.sh
RUN sudo chmod +x /home/tad/.init.sh

ENTRYPOINT "/bin/zsh"
CMD ["/home/tad/.init.sh"]



