

If you're working on a mac through kitematic, try this

``` bash
export PATH='/Users/wm284/Downloads/Kitematic (Beta).app/Contents/Resources/resources:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'  && export DOCKER_HOST=tcp://192.168.99.100:2376 && export DOCKER_CERT_PATH=/Users/wm284/.docker/machine/machines/dev && export DOCKER_TLS_VERIFY=1 >>~/.zshrc
source ~/.zshrc
```
