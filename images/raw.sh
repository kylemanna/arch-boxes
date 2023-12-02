#!/bin/bash
CFG=$(sed -e 's:.*/\(.*\).sh:\1:' <<< "$BASH_SOURCE" )
# shellcheck disable=SC2034,SC2154
IMAGE_NAME="Arch-Linux-x86_64-basic-${CFG}-${build_version}.bin"
# It is meant for local usage so the disk should be "big enough".
#DISK_SIZE="3G"
DISK_SIZE=""
PACKAGES=()
SERVICES=()

function pre() {
  #local NEWUSER="arch"
  #arch-chroot "${MOUNT}" /usr/bin/useradd -m -U "${NEWUSER}"
  #echo -e "${NEWUSER}\n${NEWUSER}" | arch-chroot "${MOUNT}" /usr/bin/passwd "${NEWUSER}"
  #echo "${NEWUSER} ALL=(ALL) NOPASSWD: ALL" >"${MOUNT}/etc/sudoers.d/${NEWUSER}"
  mkdir -pv "${MOUNT}/root/.ssh/"
  echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+OBvmOaeeJHwjdjRfhL8S7Jb2fOELKS2At+Bsp83k8YuPTFglTu1qgA7iNaePwtXhH49efwpkLhZG9BLzgMGZcWNTSt6tvCNmN7H5xP4GR8arAfK0x9zeLLDeztLxVGM82j931gfivmUQDEdGeChMnJEAVvxWiL2vSyeuGTc4Jr1szqUEyBOhPtVpHo1vOoeh0SLYJj3HfNTep9AGlaR/xgiHqupKo5essINRokxFJS5sV6po8el5cYjoEpyzzlrPk96uUSKUqDTZLy++M4J9bt8y6JPkzQkuiZcoPL7ANlLgwruf617izIX6lGPgP6VZBI37mSvbWMBiIPLDpHxMB9Gi/qkZI8pzGsS8m+OaJ1EgxijN+To/MoYNGbVrXXbvL5wR7PrsrbvgWd8FUJ8RZPxdTqvzEZFIty9bK2gMNMqs9E0b1gr1vi9/Jkesp3YY5dnSkwDziKDM8ml6YYm2ZZ2Op9E0Dal/IsUoogp33s9711uk6GM61PbQ9YCkSycV3UTyXpkU7AcoLULg+nzSNNlqO/jI2LD4UHp+GjS3jf+dC060POIKMHIkMRAmFepEER4FEPli5F3Ko8DNPwuupv0M9vlGBjlVln2PNFw+zE3sMHuHBhuMPa1EhbydMSxkmpc8Y08kJoCgSMc927t/KOgkJ3KZoLQmZWgK32RkjQ== cardno:5646599' > "${MOUNT}/root/.ssh/authorized_keys"

  local NET="${ORIG_PWD}/net/${CFG}.network"
  if [ -r "$NET" ]; then
    mkdir -pv "${MOUNT}/etc/systemd/network/"
    cp -v "$NET" "${MOUNT}/etc/systemd/network/80-${CFG}.network"
  else
    echo 'Failed to find network config!'
    exit 1
  fi
}

function post() {
  mv -v "${1}" "${2}"
}
