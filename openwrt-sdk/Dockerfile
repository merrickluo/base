FROM gcc:7.3.0

WORKDIR /usr/src/openwrt-sdk
RUN apt-get update && \
		apt-get install -y wget \
		build-essential libncurses5-dev gawk git subversion libssl-dev gettext zlib1g-dev unzip

ENV SDK_NAME openwrt-sdk-18.06.0-ar71xx-nand_gcc-7.3.0_musl.Linux-x86_64.tar.xz
ENV SDK_URL https://downloads.openwrt.org/releases/18.06.0/targets/ar71xx/nand/${SDK_NAME}

RUN wget ${SDK_URL} && \
		tar xvf ${SDK_NAME} --strip-components 1 && \
		./scripts/feeds update -a && \
		./scripts/feeds install -a
