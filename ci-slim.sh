#!/bin/bash

set -e

wget https://github.com/cloudimmunity/docker-slim/releases/download/1.14/dist_linux.zip
unzip dist_linux.zip

# show debug log and container log, with http-probe enabled
yes | ./dist_linux/docker-slim --debug build -p --show-clogs gentoo
