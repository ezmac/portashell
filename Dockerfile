FROM debian:latest
MAINTAINER Tad <system.root@gmail.com>

ARG USER=tad
ARG UID=1000
## INSTALL SOFTWARE 
WORKDIR /home/$USER/

ADD dotfiles /home/$USER/dotfiles
ENV DEBIAN_FRONTEND=noninteractive

# make first user able to sudo. common to all containers.
RUN adduser --uid $UID --disabled-password --shell $(which zsh) --gecos '' $USER  && \
    adduser $USER sudo && \
    bash -c "echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers" && \
    chown $USER:users /home/$USER -R && \

# do dist upgrade to be on latest debian.
#ADD sources.list /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get dist-upgrade -y && \
  apt-get install -f && \
  apt-get install -y  curl wget curl zsh git tmux php7.0-cli curl sudo ruby cmake
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

  su -l $USER -c "cd /home/$USER/dotfiles && ./go.sh" && \
  rm -rf /home/$USER/vim/ && sync &&\
  find /home/$USER/.vim/bundle/ -name .git -type d -prune -exec rm -rf {}  \; && \
  rm -rf /home/$USER/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp &&\
  rm -rf /home/$USER/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/OmniSharpServer &&\
  apt-get remove -y   build-essential checkinstall dirmngr dpkg-dev fakeroot g++ g++-6 gnupg  && \
  apt-get install -y libpython2.7 && \
  rm -rf /var/lib/apt/lists/*


# if you're on a normal system, 1000 is a good guess for a single user.


USER $USER

# thanks valloric
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source#



ENTRYPOINT ["/bin/zsh"]
