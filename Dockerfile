FROM ubuntu:20.04

COPY HOBBES_* /tmp/
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y git cmake make g++ python2.7 llvm-dev zlib1g-dev libreadline-dev && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/morganstanley/hobbes && \
    cd hobbes && \
    git reset --hard $(cat /tmp/HOBBES_COMMIT_HASH) && \
    cmake . && \
    make && \
    make install && \
    cd / && \
    apt-get remove -y git cmake make g++ python2.7 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /opt/hobbes /var/lib/apt/lists/*
