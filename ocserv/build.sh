#!/bin/sh

set -e

# dep
dep="libev-dev gnutls-dev gnutls-utils linux-pam-dev lz4-dev"
build_dep="build-base curl autoconf automake readline-dev libnl3-dev linux-headers gperf"

apk update
apk add $build_dep $dep

# source build and install
cd
curl -fSL ftp://ftp.infradead.org/pub/ocserv/ocserv-0.11.2.tar.xz  -o ocserv.tar.xz
tar -xJf ocserv.tar.xz
mv ocserv-* ocserv
cd ocserv

sed -i '/#define DEFAULT_CONFIG_ENTRIES /{s/96/200/}' src/vpn.h
./configure
make
make install

# make configuration folder
mkdir -p /etc/ocserv

# clean
# notice that occtl requires libnl3-dev and readline-dev
apk del $build_dep
rm /var/cache/apk/*
rm -r /root/*
