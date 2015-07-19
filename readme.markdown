# portable shell

## inspiration

I got tired of getting on a server and not having my dotfiles, so I decided to dockerize them. If I'm on a server without docker, usually I'm too restricted to do anything useful anyway.  This gets me to a point where I can docker run -it ezmac/shell anywhere there's docker. Winning.


If you're working on a mac through kitematic, try this

``` bash
export PATH='~/Downloads/Kitematic (Beta).app/Contents/Resources/resources:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'  && export DOCKER_HOST=tcp://192.168.99.100:2376 && export DOCKER_CERT_PATH=~.docker/machine/machines/dev && export DOCKER_TLS_VERIFY=1 >>~/.zshrc
source ~/.zshrc
# assumes you're running zsh. You are running zsh, right?!
```
