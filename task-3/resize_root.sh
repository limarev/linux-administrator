#!/bin/bash

lsblk
pvcreate /dev/sdb
vgcreate vg_tmp_root /dev/sdb
lvcreate -n lv_tmp_root -l +100%FREE /dev/vg_tmp_root
mkfs.xfs /dev/vg_tmp_root/lv_tmp_root
mount /dev/vg_tmp_root/lv_tmp_root /mnt
xfsdump -J - /dev/cs_otus-c8/root | xfsrestore -J - /mnt
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
chroot /mnt/ /bin/sh -x << EOF
echo 'GRUB_DISABLE_OS_PROBER=true' >> /etc/default/grub
sed -i 's/rd\.lvm\.lv=cs_otus-c8\/root/rd\.lvm\.lv=vg_tmp_root\/lv_tmp_root/g' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
cd /boot
for i in $(ls initramfs-*img); do dracut -v $i `echo $i | sed 's/initramfs-//g;  s/.img//g'` --force; done
EOF
lsblk
shutdown -r now