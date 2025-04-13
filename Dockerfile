FROM ghcr.io/douglasdgoulart/linux:base

WORKDIR /linux-build

COPY . .

RUN make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- business_card_defconfig
RUN make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc) all
RUN make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc) modules
RUN mkdir -p out
RUN make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc) modules_install INSTALL_MOD_PATH=out/

ENTRYPOINT ["/bin/bash"]
