---
title: "disk"
date: 2014-11-03 10:52
---
+ ``dd if=/dev/zero of=/tmp/swapfile bs=1024k count=10`` ``mkswap -f /tmp/swapfile`` ``swapon /tmp/swapfile``
+ ``swapon -s``显示fstab中交换分区信息
+ ``swapon -a``将``/etc/fstab``文件中所有设置为swap的设备开启，标记noauto参数的设备除外
+ ``swapoff -a``将``/etc/fstab``文件中所有设置为swap的设备关闭
+ ``swapoff /tmp/swapfile``
+ disk uuid [ubuntu.ref](https://help.ubuntu.com/community/Fstab)
+ ``sudo mount -a`` mount all file systems in ``/etc/fstab``

```
$sudo blkid
/dev/sda1: UUID="208d621f-5e2e-4e21-bb91-3ab1654631bd" TYPE="ext4" 
/dev/sda5: UUID="4ff30db3-2fbf-4567-865e-20cf11ae9ae0" TYPE="swap" 
/dev/sda6: UUID="8b6f7402-a8d3-49a2-94ae-db05006a03ac" TYPE="ext4" 
/dev/sda7: UUID="39431f38-69ba-4092-8cef-0abd78a1b76e" TYPE="ext4" 
/dev/sdb: LABEL="SSD" UUID="6b750347-c706-4614-8f69-a0e0d0f6fc81" TYPE="ext4"
$cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
proc            /proc           proc    nodev,noexec,nosuid 0       0
# / was on /dev/sde6 during installation
UUID=8b6f7402-a8d3-49a2-94ae-db05006a03ac /               ext4    errors=remount-ro 0       1
# /boot was on /dev/sde1 during installation
UUID=208d621f-5e2e-4e21-bb91-3ab1654631bd /boot           ext4    defaults        0       2
# /home was on /dev/sde7 during installation
UUID=39431f38-69ba-4092-8cef-0abd78a1b76e /home           ext4    defaults        0       2
# swap was on /dev/sde5 during installation
UUID=4ff30db3-2fbf-4567-865e-20cf11ae9ae0 none            swap    sw              0       0
# ssd
UUID=6b750347-c706-4614-8f69-a0e0d0f6fc81 /media/ssd      ext4    defaults        0       2
```

