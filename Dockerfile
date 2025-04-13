FROM ghcr.io/douglasdgoulart/linux:master

ARG BRANCH=master

WORKDIR /linux-build

RUN git fetch origin ${BRANCH} && \
    git checkout ${BRANCH} && \
    git pull origin ${BRANCH} && \
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- business_card_defconfig && \
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc) all && \
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc) modules && \
    mkdir -p out && \
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc) modules_install INSTALL_MOD_PATH=out/

ENTRYPOINT ["/bin/bash"]
