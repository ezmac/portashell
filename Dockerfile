FROM debian
MAINTAINER Tad Merchant <system.root@gmail.com>

## INSTALL SOFTWARE 

# do dist upgrade to be on latest debian.
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

# install incron and supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl zsh git tmux

# thanks valloric
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source#
ADD installVim.sh /root/

RUN DEBIAN_FRONTEND=noninteractive chmod u+x /root/installVim.sh
RUN DEBIAN_FRONTEND=noninteractive /root/installVim.sh
