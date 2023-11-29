#/bin/bash
h=$1
ssh root@$h pacman -S --noconfirm parted
ssh -t root@$h parted /dev/vda print
ssh -t root@$h parted /dev/vda resizepart 3 100%
ssh root@$h partprobe
ssh root@$h btrfs fi usage /
ssh root@$h btrfs fi resize max /
ssh root@$h btrfs fi usage /
ssh root@$h pacman -Rscn --noconfirm parted
