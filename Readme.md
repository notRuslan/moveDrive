Move live system CentOS 7 to new drive.

После первой загрузки

 `next actions`
 ```
 1. for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
 2. chroot /mnt/
 3. grub2-mkconfig -o /boot/grub2/grub.cfg
 Prepare fstab
 4. lsblk -f /dev/sdb |sed 's/\[SWAP]/swap /g'|awk '/(-)/{printf"UUID=%-36s %-23s %-7s defaults   0 0\n", $3, ($4==""?mnt""NR:$4), $2}'>> /etc/fstab
 5. исправить fstab : удалить старые линии и исправить строку swap 
    vim /etc/fstab
 6. grub2-install /dev/sdb
 7. exit
 ```
 **At the VirtualBox boot press F12 and choose second drive, then 2**
 
