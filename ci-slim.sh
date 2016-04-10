#!/bin/bash

set -e

wget https://github.com/cloudimmunity/docker-slim/releases/download/1.14/dist_linux.zip
unzip dist_linux.zip

yes | ./dist_linux/docker-slim build gentoo
