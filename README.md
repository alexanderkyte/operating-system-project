Not much to see here yet. Probably not the most usable OS even when finished. My goal is to get an operating system written as a learning experience.

Note: The build scripts/makefiles will only work on an i386 pc. Build requirements include sh, a linux build host, and the nasm assembler.  

Design Decisions:

	-I'm using a monolithic kernel, simply because its what linux, windows, os <= 8.6, and the BSD unices use. 
	-I want to make it a monotask system initially, I'll add a scheduler later. Might be traditional multitasking, but real-time looks interesting. 
	-This OS is never going to run on raw hardware. Its going to be virutualized. 	
	-Paging rather than memory segmentation(Do I need paging for a monotask system?) -Will: "Nope"
	-Grub bootloader
	-NASM, because I like the syntax better

I'm using a number of osdev tutorials. GDT table code is mostly boilerplate, so I've wholesale stolen it from the tutorial which I used the most. All credit to: https://www.jamesmolloy.co.uk/
This code has a "do whatever the hell you want, don't blame me for anything done with it." license. If you manage to get someone to pay for the code, while informing them that its all online here and the logic is available in a variety of other places, then you are good enough of a salesman that you deserve to keep that money. 
