#!/bin/bash
# This script mounts the boot floppy image, copies the kernel you've written in src/kernel to it, and then unmounts it. 
mkdir ./grubwrite
# losetup is a loop device and control toolset. This makes the grub boot floppy mounted at loop device /dev/loop0
sudo mount -o loop src/grubfloppy.img ./grubwrite 
sudo cp ./src/kernel ./grubwrite/kernel
sudo umount grubwrite
rm -r grubwrite
