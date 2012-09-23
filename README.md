Not much to see here yet. Probably not the most usable OS even when finished. My goal is to get an operating system written as a learning experience.

Design Decisions:

	-I'm using a monolithic kernel, simply because its what linux, windows, os <= 8.6, and the BSD unices use. 
	-I want to make it a monotask system initially, I'll add a scheduler later. Might be traditional multitasking, but real-time looks interesting. 
	-This OS is never going to run on raw hardware. Its going to be virutualized. 	
	-Paging rather than memory segmentation(Do I need paging for a monotask system?) -Will: "Nope"
	-Grub bootloader
	-NASM, because I like the syntax better
