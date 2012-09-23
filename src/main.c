// main.c -- Defines the C-code kernel entry point, calls initialisation routines.
// Made for JamesM's tutorials
// This is the main() that the boot.s calls after disabling interrupts


int main(struct multiboot *mboot_ptr)
{
  // Takes a pointer to mboot, exactly what grub places in ebx, and gets pushed to the stack. By the cde calling convention, thats where this C function is going to try to grab that pointer from. 
  // All our initialisation calls will go in here.
  return 0xDEADBABA;
} 
