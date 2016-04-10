# Base Image

Gentoo-stage 3 has less/more/cat/netstat inside, this adds nc/curl/gentoolkit/vim/emacs(not alphabetically ordered).

## Build/Update Notes

Auto builds are in [Docker Hub](https://hub.docker.com/r/ahxxm/gentoo/).

Image that use this base image can be slimmed using [docker-slim](https://github.com/cloudimmunity/docker-slim):

    docker build -t some-image .
    ./docker-slim build some-image

slimmed image named some-image.slim.
