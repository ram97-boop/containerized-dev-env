FROM ubuntu:22.04

RUN apt update && apt install -y vim
RUN apt install -y sudo
RUN apt install -y less
RUN apt install -y file
RUN apt install -y iproute2

ENV TERM=xterm-color

RUN useradd -m -s /usr/bin/bash developer
RUN passwd -d developer
RUN usermod -aG sudo developer
COPY ./.vimrc /home/developer
USER developer
WORKDIR /home/developer/workspace

CMD ["bash"]

## An example command to build a container of this image
# docker build -t <image-name> .

## An example command to run a container of this image
# docker run -it -v .:/home/developer/workspace:z <image-name>

## The command line command for running a code-server container with the current host directory mounted on /workspace in the container.
# docker run -v code_server_config_volume:/config -v .:/workspace -e PUID=1000 -e PGID=1000 -e DEFAULT_WORKSPACE=/workspace -p 8443:8443 linuxserver/code-server
