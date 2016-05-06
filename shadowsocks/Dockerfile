FROM alpine:latest

ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/archive/master.zip
ENV SS_DIR shadowsocks
ENV SS_DEP autoconf build-base curl libtool linux-headers openssl-dev unzip

RUN set -ex \
    && apk add --update $SS_DEP \
    && curl -fSL $SS_URL -o master.zip \
    && unzip master.zip \
    && mv shadowsocks-libev* $SS_DIR \
    && cd $SS_DIR \
        && ./configure \
        && make -j8 \
        && make install \
        && cd .. \
        && rm -rf $SS_DIR \
    && apk del --purge $SS_DEP \
    && rm -rf /var/cache/apk/* \
    && rm master.zip \
    && rm -r $SS_DIR

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
