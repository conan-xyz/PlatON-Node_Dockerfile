FROM zonzpoo/ubuntu:18.04

LABEL maintainer="PlatON Node Docker Maintainers <golang.py@gmail.com>"

ENV PLATONGO_VERSION release-0.9.0

RUN set -x \
    && apt update \
    && apt install -y gcc g++ cmake git software-properties-common libgmp-dev libssl-dev\
    && add-apt-repository -y ppa:longsleep/golang-backports \
    && apt update \
    && apt install -y golang-go \
    && mkdir -pv ~/platon-node/data 

WORKDIR /root/platon-node
RUN git clone -b ${PLATONGO_VERSION} https://github.com/PlatONnetwork/PlatON-Go.git --recursive

WORKDIR /root/platon-node/PlatON-Go
RUN git branch \
    && find /root/platon-node/PlatON-Go/build -name "*.sh" -exec chmod u+x {} \; \
    && make all \
    && echo "export PATH=/root/platon-node/PlatON-Go/build/bin:$PATH" >> /root/.bashrc

STOPSIGNAL SIGTERM

CMD ["bash"]
