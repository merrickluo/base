#!/bin/sh
set -e


# ref:
# - https://www.futures.moe/writings/configure-nginx-with-security-and-effective-yes-or-no.htm
NGINX_VERSION=1.11.6
LIBRESSL_VERSION=2.4.4

mkdir -p /tmp

# dependencies
build_dep="curl gnupg build-base pcre-dev zlib-dev linux-headers openssl-dev"
run_dep="ca-certificates openssl pcre zlib"

apk --no-cache add ${build_dep} ${run_dep}
gpg --keyserver pgp.mit.edu --recv-keys A1EB079B8D3EB92B4EBD3139663AF51BD5E4D8D5
gpg --keyserver pgp.mit.edu --recv-keys B0F4253373F8F6F510D42178520A9993A1C052F8

adduser -D -s /sbin/nologin www-data

# LibreSSL
cd /tmp
curl -fSL http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${LIBRESSL_VERSION}.tar.gz -o libressl-${LIBRESSL_VERSION}.tar.gz
curl -fSL http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${LIBRESSL_VERSION}.tar.gz.asc -o libressl-${LIBRESSL_VERSION}.tar.gz.asc
gpg --batch --verify libressl-${LIBRESSL_VERSION}.tar.gz.asc libressl-${LIBRESSL_VERSION}.tar.gz
tar -zxf libressl-${LIBRESSL_VERSION}.tar.gz


# nginx
# check http://nginx.org/en/download.html for the latest version
cd /tmp
curl -fSL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -o nginx-${NGINX_VERSION}.tar.gz
curl -fSL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz.asc -o nginx-${NGINX_VERSION}.tar.gz.asc
gpg --batch --verify nginx-${NGINX_VERSION}.tar.gz.asc nginx-${NGINX_VERSION}.tar.gz
tar -zxf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
./configure \
    --user=www-data \
    --group=www-data \
    --prefix=/usr/local/nginx \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-ipv6 \
    --with-http_v2_module \
    --with-openssl=/tmp/libressl-${LIBRESSL_VERSION} \
    --with-ld-opt="-lrt"
make -j $(getconf _NPROCESSORS_ONLN)
make install
make clean
rm -rf /tmp /root/.gnupg/
apk del ${build_dep}

# nginx binary add to path
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
