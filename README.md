# Base Image


## Build/Update Notes

Auto builds are in [Docker Hub](https://hub.docker.com/r/ahxxm/gentoo/).

Manual build with [docker-slim](https://github.com/cloudimmunity/docker-slim):

    docker build -t gentoo:slim .
    ./docker-slim build gentoo:slim
