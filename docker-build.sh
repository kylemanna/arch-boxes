#!/bin/bash
set -ex
docker build -t arch-builder .
b="$PWD"
export SUDO_UID=$(stat -c "%u" "$b")
export SUDO_GID=$(stat -c "%g" "$b")
exec docker run --rm -it \
    --privileged \
    --workdir /b \
    -e SUDO_GID \
    -e SUDO_UID \
    -e SECTOR_SIZE \
    -v "$b:/b" \
    -v /dev:/dev \
    -v /run/udev:/run/udev \
    -v /var/cache/pacman/pkg/:/var/cache/pacman/pkg/:ro \
    arch-builder bash ./build.sh $@
