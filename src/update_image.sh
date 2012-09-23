#!/bin/bash
# This script mounts the boot floppy image, copies the kernel you've written in src/kernel to it, and then unmounts it. 
sudo losetup /dev/loop0 grubfloppy.img
# losetup is a loop device and control toolset. This makes the grub boot floppy mounted at loop device /dev/loop0
sudo mount /dev/loop0 /mnt
sudo cp src/kernel /mnt/kernel
sudo umount /dev/loop0
sudo losetup -d /dev/loop0 
