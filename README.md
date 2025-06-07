# Containerized Development Environment

SELinux blocks the container's access to the directory /var/lib/code-server-config, which it mounts. To enable access from the container a couple of things had to be done.
I followed this guide: https://www.redhat.com/en/blog/supplemental-groups-podman-containers

- create a group (e.g. codeserverconfig)
  ```bash
  groupadd codeserverconfig
  ```
- add my user to the group
  ```bash
  usermod -a -G codeserverconfig <user>
  ```
- change group access for the directory
  ```bash
  chown root:codeserverconfig /var/lib/code-server-config
  ```
- change permissions to allow the group to write to the directory
  ```bash
  chmod 770 /var/lib/code-server-config
  ```
- change SELinux type of the directory so that containers can use it
  ```bash
  chcon -t container_file_t /var/lib/code-server-config
  ```
- log out and in so that my user is added in the codeserverconfig group (can check with `id` command)
- run
  ```bash
  podman run --rm \
    --userns=keep-id \
    -v $HOME/projects:/config/workspace:z \
    -v /var/lib/code-server-config:/config \
    --name code-server \
    --env PUID=1000 \
    --env PGID=1000 \
    --env TZ=Europe/Stockholm \
    -p 8443:8443 \
    --annotation run.oci.keep_original_groups=1 \
    docker.io/linuxserver/code-server:4.100.2-ls275
  ```
  above command is the CLI equivalent to the docker-compose.yaml

