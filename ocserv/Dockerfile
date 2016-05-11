FROM alpine:latest

# Usage: ocserv -c /etc/ocserv/ocserv.conf -f -d 1

COPY build.sh /build.sh
RUN /build.sh && rm /build.sh
