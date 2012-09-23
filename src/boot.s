 ;
; boot.s -- Kernel start location. Also defines multiboot header.
; Based on Bran's kernel development tutorial file start.asm
;
; Virtually unchanged by Alex Kyte, but further commented in accordance with reading for posterity. I'm not the most concerned with bootloader writing. 

MBOOT_PAGE_ALIGN    equ 1<<0    ; Load kernel and modules on a page boundary
MBOOT_MEM_INFO      equ 1<<1    ; Provide your kernel with memory info
MBOOT_HEADER_MAGIC  equ 0x1BADB002 ; Multiboot Magic value that lets grub know that this kernel plays by the rules. 
; NOTE: We do not use MBOOT_AOUT_KLUDGE. It means that GRUB does not
; pass us a symbol table.
MBOOT_HEADER_FLAGS  equ MBOOT_PAGE_ALIGN | MBOOT_MEM_INFO ; The grub flags. We ask for page alignment, and memory information to be provided. 
MBOOT_CHECKSUM      equ -(MBOOT_HEADER_MAGIC + MBOOT_HEADER_FLAGS) ; The checksum. 


[BITS 32]                       ; All instructions should be 32-bit. #Unchanged, as I've chosen a 32-bit OS. 

[GLOBAL mboot]                  ; Make 'mboot' accessible from C. #These work because of the earlier linker script.
[EXTERN code]                   ; Start of the '.text' section.
[EXTERN bss]                    ; Start of the .bss section.
[EXTERN end]                    ; End of the last loadable section.


mboot:
  dd  MBOOT_HEADER_MAGIC        ; GRUB will search for this value on each
                                ; 4-byte boundary in your kernel file
  dd  MBOOT_HEADER_FLAGS        ; How GRUB should load your file / settings
  dd  MBOOT_CHECKSUM            ; To ensure that the above values are correct
   
  dd  mboot                     ; Location of this descriptor. This is what later ends up in ebx below. 
  dd  code                      ; Start of kernel '.text' (code) section. # These are all declared in the linker script, and I recognize them as basic fields of an elf executable. 
  dd  bss                       ; End of kernel '.data' section.
  dd  end                       ; End of kernel.
  dd  start                     ; Kernel entry point (initial EIP).

; This is all just code that Grub expects really. This allows the kernel to query the environment its in, and tell that environment about the weird things it wants the bootloader to ensure before it boots.  
; As per the specs, this header must be the first 4KB of the kernel. We embed the fields with the dd (declare doubleword) asm command. 
;

[GLOBAL start]                  ; Kernel entry point.
[EXTERN main]                   ; This is the entry point of our C code

start:
  push    ebx                   ; Load multiboot header location (Pushes to stack) #Why is it in ebx? I'm gonna assume the grub boot floppy has some assembly that places the address of the header that it reads(that we just created in mboot) into ebx. Grub is useful, but weird.  

  ; Execute the kernel:
  cli                         ; Disable interrupts. # First step in moving to protected memory!(Also the only step, if I'm not mistaken, that can't be done in C. This placement makes sense.) All this portion of code actually does is jump to externally declared C code at main. 
  call main                   ; call our main() function.
  jmp $                       ; Enter an infinite loop, to stop the processor
                              ; executing whatever rubbish is in the memory
                              ; after our kernel! 
