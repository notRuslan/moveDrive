#!/usr/bin/env bash

echo "--------------------START SCRIPT------------------------------"

yum install -y bash-completion tree vim gdisk

#SELinux to permissive
setenforce 0
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

#
#
parted -s /dev/sdb mklabel msdos
#
# Boot
parted /dev/sdb mkpart primary ext2 1MiB 1GiB
#root /
parted /dev/sdb mkpart primary ext4 1GiB 5GiB
#swap
parted /dev/sdb mkpart primary linux-swap 5GiB 6GiB
#boot
mkfs.ext2 /dev/sdb1
# root /
mkfs.ext4 /dev/sdb2
# swap
mkswap /dev/sdb3

# mount and copy /
mount /dev/sdb2 /mnt  && rsync -axvu / /mnt


#mount boot
mount /dev/sdb1 /mnt/boot && rsync -axvu /boot/ /mnt/boot


ls -la /mnt/boot
echo "------------------------------------------------------------"
lsblk
echo "------------------------------------------------------------"
df -h

echo "--------------------END SCRIPT------------------------------"

# next actions
# for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done

# chroot /mnt/
# blkid /dev/sdb* >> /etc/fstab
# lsblk -f /dev/sdb |sed 's/\[SWAP]/swap /g'|awk '/(-)/{printf"UUID=%-36s %-23s %-7s defaults   0 0\n", $3, ($4==""?mnt""NR:$4), $2}'>> /etc/fstab
# fix fstab : delete old lines and fix swap line
# vim /etc/fstab

#grub2-mkconfig -o /boot/grub2/grub.cfg
#grub2-install /dev/sdb
#exit

# At the VirtualBox boot press F12 and choose second drive




