

После первой загрузки
# next actions
# for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done

# chroot /mnt/
# blkid /dev/sdb* >> /etc/fstab
# lsblk -f /dev/sdb |sed 's/\[SWAP]/swap /g'|awk '/(-)/{printf"UUID=%-36s %-23s %-7s defaults   0 0\n", $3, ($4==""?mnt""NR:$4), $2}'>> /etc/fstab
# справить fstab : удалить старые линии и исправить строку swap 
# vim /etc/fstab

#grub2-mkconfig -o /boot/grub2/grub.cfg
#grub2-install /dev/sdb
#exit

# At the VirtualBox boot press F12 and choose second drive
