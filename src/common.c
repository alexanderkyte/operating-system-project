// common.c -- Defines some global functions.
// From JamesM's kernel development tutorials.

#include "common.h"

// Write a byte out to the specified port.
// Alex - The volatile keyword for asm tells us that the memory affected is not listed as a direct output/input
// outX sends a byte to an IO location, where X is b for byte, or w for word, or even l for long sometimes. a enforced that the value is going to eax, and dN puts it in edx
// Thus, this is a fairly simple set of functions that wrap the outX and inX instruction sets for use for ASCII framebuffer characters.

void outb(u16int port, u8int value)
{
    asm volatile ("outb %1, %0" : : "dN" (port), "a" (value));
}

u8int inb(u16int port)
{
   u8int ret;
   asm volatile("inb %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
}

u16int inw(u16int port)
{
   u16int ret;
   asm volatile ("inw %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
} 
