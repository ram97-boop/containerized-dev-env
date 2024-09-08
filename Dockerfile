FROM ubuntu:22.04

RUN apt update && apt install -y vim
RUN apt install -y sudo
RUN apt install -y less
RUN apt install -y file
RUN apt install -y iproute2

ENV TERM=xterm-color

RUN useradd -m -s /usr/bin/bash dev
RUN passwd -d dev
RUN usermod -aG sudo dev
COPY ./.vimrc /home/dev
USER dev
WORKDIR /home/dev
