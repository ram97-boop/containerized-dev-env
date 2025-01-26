FROM python:3.13.1-bookworm

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
WORKDIR /home/dev/workspace

## An example command to build a container of this image
# docker build -t <container-name> .

## An example command to run a container of this image
# docker run -it -v .:/home/dev/workspace <container-name>

## The command line command for running a code-server container with the current host directory mounted on /workspace in the container.
# docker run -v code_server_config_volume:/config -v .:/workspace -e PUID=1000 -e PGID=1000 -e DEFAULT_WORKSPACE=/workspace -p 8443:8443 linuxserver/code-server
