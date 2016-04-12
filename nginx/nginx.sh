#!/bin/bash

# ref:
# - https://developers.google.com/speed/pagespeed/module/build_ngx_pagespeed_from_source#dependencies
# - https://www.futures.moe/writings/configure-nginx-with-security-and-effective-yes-or-no.htm

set -e

NPS_VERSION=1.11.33.0
NGINX_VERSION=1.9.14
LIBRESSL_VERSION=2.3.3 # nice shot


# LibreSSL
cd
wget http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${LIBRESSL_VERSION}.tar.gz
tar xf libressl-${LIBRESSL_VERSION}.tar.gz

# Page speed
cd
wget -q https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.zip -O release-${NPS_VERSION}-beta.zip
unzip -qq release-${NPS_VERSION}-beta.zip
cd ngx_pagespeed-release-${NPS_VERSION}-beta/
wget -q https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
tar -xzvf ${NPS_VERSION}.tar.gz --no-same-owner  # extracts to psol/


# Add new user
groupadd www
useradd -s /sbin/nologin -g www www

# nginx
# check http://nginx.org/en/download.html for the latest version
cd
wget -q http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar xf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
./configure \
    --user=www \
    --group=www \
    --prefix=/usr/local/nginx \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-ipv6 \
    --with-http_v2_module \
    --with-openssl=$HOME/libressl-${LIBRESSL_VERSION} \
    --with-ld-opt="-lrt" \
    --add-module=$HOME/ngx_pagespeed-release-${NPS_VERSION}-beta ${PS_NGX_EXTRA_FLAGS}
make -j8
make install


# TODO: post install configure


