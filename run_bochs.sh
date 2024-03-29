#!/bin/bash

# run_bochs.sh
# mounts the correct loopback device, runs bochs, then unmounts.
# Taken from JamesM's tutorial. Nice bochs script. 
sudo modprobe loop
sudo /sbin/losetup /dev/loop0 src/grubfloppy.img
sudo bochs -f bochsrc.txt
sudo /sbin/losetup -d /dev/loop0
tail -n 20 bochsout.txt
