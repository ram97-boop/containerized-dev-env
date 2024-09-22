FROM ubuntu:22.04

RUN apt update && apt install -y vim
RUN apt install -y sudo
RUN apt install -y less
RUN apt install -y file
RUN apt install -y iproute2
RUN apt update && apt install -y build-essential

ENV TERM=xterm-color

RUN useradd -m -s /usr/bin/bash dev
RUN passwd -d dev
RUN usermod -aG sudo dev
COPY ./.vimrc /home/dev
USER dev
WORKDIR /home/dev

COPY ./nasm-2.16.03.tar.gz /home/dev
RUN tar -xzf nasm-2.16.03.tar.gz \
    && cd nasm-2.16.03 \
    && ./configure \
    && make \
    && sudo make install

## An example command to run a container of this image
# docker run -it -v .:/home/dev dev-env

## The command line command for running a code-server container with the current host directory mounted on /workspace in the container.
# docker run -v code_server_config_volume:/config -v .:/workspace -e PUID=1000 -e PGID=1000 -e DEFAULT_WORKSPACE=/workspace -p 8443:8443 linuxserver/code-server
