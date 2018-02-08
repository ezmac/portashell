FROM debian:latest
MAINTAINER Tad Merchant <system.root@gmail.com>

## INSTALL SOFTWARE 

# do dist upgrade to be on latest debian.
#ADD sources.list /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -f

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  wget 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  curl 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  zsh 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  tmux

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo ruby cmake
ARG USER

RUN echo $USER
### Hmm DIND?
RUN DEBIAN_FRONTEND=noninteractive wget -qO- https://get.docker.com/ | sh

# if you're on a normal system, 1000 is a good guess for a single user.
RUN adduser --uid 1000 --disabled-password --gecos '' $USER  && adduser $USER sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN usermod -aG docker $USER




USER $USER
RUN DEBIAN_FRONTEND=noninteractive sudo chsh -s $(which zsh)

# thanks valloric
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source#
ADD dotfiles /home/$USER/dotfiles

RUN sudo chown $USER:users /home/$USER -R
RUN DEBIAN_FRONTEND=noninteractive chmod u+x /home/$USER/dotfiles/installVim.sh
RUN DEBIAN_FRONTEND=noninteractive /home/$USER/dotfiles/installVim.sh

RUN DEBIAN_FRONTEND=noninteractive cd /home/$USER && curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | /bin/bash
ADD ohmyzsh.sh /home/$USER/.ohmyzsh.sh

RUN DEBIAN_FRONTEND=noninteractive cd /home/$USER && sudo chmod +x .ohmyzsh.sh; sync && ./.ohmyzsh.sh


WORKDIR /home/$USER/dotfiles

ENV TERM xterm


RUN DEBIAN_FRONTEND=noninteractive /home/$USER/dotfiles/installDocker.sh
RUN DEBIAN_FRONTEND=noninteractive /home/$USER/dotfiles/installFZF.sh
RUN DEBIAN_FRONTEND=noninteractive /home/$USER/dotfiles/installNeobundle.sh


RUN DEBIAN_FRONTEND=noninteractive /home/$USER/dotfiles/installPowerlineFont.sh

RUN DEBIAN_FRONTEND=noninteractive /home/$USER/dotfiles/linkDotfiles.sh

RUN DEBIAN_FRONTEND=noninteractive /bin/bash -c "source /home/$USER/dotfiles/.zshrc" && /bin/bash -c "/home/$USER/dotfiles/installNodenv.sh"
RUN DEBIAN_FRONTEND=noninteractive /bin/bash -c "source /home/$USER/dotfiles/.zshrc" && /bin/bash -c "/home/$USER/dotfiles/installRbenv.sh"
WORKDIR /home/$USER/

ENTRYPOINT "/bin/zsh"



