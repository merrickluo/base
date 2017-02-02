FROM alpine:latest

ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev
ENV SS_DIR shadowsocks-libev
ENV SS_DEP pcre openssl-dev libsodium-dev mbedtls-dev udns-dev libev-dev
ENV BUILD_DEP autoconf automake build-base curl libtool linux-headers unzip asciidoc xmlto pcre-dev git

RUN set -ex \
    && apk add --update $SS_DEP $BUILD_DEP \
    && git clone --recursive --depth=1 $SS_URL \
    && cd $SS_DIR \
        && ./autogen.sh \
        && ./configure \
        && make -j8 \
        && make install \
        && cd .. \
        && rm -rf $SS_DIR \
    && apk del --purge $BUILD_DEP \
    && rm -rf /var/cache/apk/*

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-cfb
ENV TIMEOUT     300
ENV DNS_ADDR    8.8.8.8

EXPOSE $SERVER_PORT
EXPOSE $SERVER_PORT/udp

CMD ss-server -s $SERVER_ADDR \
              -p $SERVER_PORT \
              -k ${PASSWORD:-$(hostname)} \
              -m $METHOD \
              -t $TIMEOUT \
              --fast-open \
              -d $DNS_ADDR \
              -u
