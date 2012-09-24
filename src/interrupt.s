; When processor recieves interrupt, it saves all important things to the stack. 
; It then finds the interrupt handler from the IDT and jumps to it. 
; Which interrupt was called isn't provided in that, so we need a different int handler for each interrupt. We can just write a bunch of handlers that then call a common function while passing in their identity. 
; Because some need errors, we need to allocate a common stack frame for all error functions, and just pass null values for a non-error code. 
;  	Each handler will be of this form:
; [GLOBAL isr#]
; isr0:
;   cli                 ; Disable interrupts
;   push byte 0         ; Push a dummy error code (if interrupt doesn't push it's own error code)
;   push byte #         ; Push the interrupt number
;   jmp isr_common_stub ; Go to our handler. 

 %macro ISR_NOERRCODE 1  ; define a macro, taking as a parameter the ISR error code.
  [GLOBAL isr%1]        
  isr%1:
    cli
    push byte 0
    push byte %1
    jmp isr_common_stub
%endmacro

%macro ISR_ERRCODE 1
  [GLOBAL isr%1]
  isr%1:
    cli
    push byte %1
    jmp isr_common_stub
%endmacro 

; Call the macros. 8, and 10-14 are the only error interrupts
ISR_NOERRCODE 0
ISR_NOERRCODE 1
ISR_NOERRCODE 2
ISR_NOERRCODE 3
ISR_NOERRCODE 4
ISR_NOERRCODE 5
ISR_NOERRCODE 6
ISR_NOERRCODE 7
ISR_ERRCODE   8
ISR_NOERRCODE 9
ISR_ERRCODE   10
ISR_ERRCODE   11
ISR_ERRCODE   12
ISR_ERRCODE   13
ISR_ERRCODE   14
ISR_NOERRCODE 15
ISR_NOERRCODE 16
ISR_NOERRCODE 17
ISR_NOERRCODE 18
ISR_NOERRCODE 19
ISR_NOERRCODE 20
ISR_NOERRCODE 21
ISR_NOERRCODE 22
ISR_NOERRCODE 23
ISR_NOERRCODE 24
ISR_NOERRCODE 25
ISR_NOERRCODE 26
ISR_NOERRCODE 27
ISR_NOERRCODE 28
ISR_NOERRCODE 29
ISR_NOERRCODE 30
ISR_NOERRCODE 31

[EXTERN isr_handler]

isr_common_stub:
   pusha                    ; Pushes edi,esi,ebp,esp,ebx,edx,ecx,eax to the stack like the implementation of a kernel interrupt is specified to do.

   mov ax, ds               ; Lower 16-bits of eax = ds, the data segment. 
   push eax                 ; save the data segment descriptor to the stack, as per the specs

   mov ax, 0x10  ; load the kernel data segment descriptor into all of the segments by pushing the value 16 into them.
   mov ds, ax
   mov es, ax
   mov fs, ax
   mov gs, ax

   call isr_handler

   pop eax        ; reload the original data segment descriptor; all of the previous stuff in reverse
   mov ds, ax
   mov es, ax
   mov fs, ax
   mov gs, ax

   popa                     ; Pops edi,esi,ebp,esp,ebx,edx,ecx,eax that we previously pushed. 
   add esp, 8     ; Cleans up the pushed error code and pushed ISR number
   sti
   iret           ; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP


