FROM archlinux

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        arch-install-scripts \
        btrfs-progs \
        dosfstools \
        gptfdisk \
        jq \
        qemu-img
