#!/bin/sh
apk add --update py-pip openssl python3 
apk add --update build-base zeromq-dev python-dev python3-dev freetype-dev libpng-dev
ln -s /usr/include/locale.h /usr/include/xlocale.h
pip3 install --no-cache-dir "ipython[all]" pandas matplotlib
apk del build-base
