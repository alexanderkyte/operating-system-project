## Taken from JamesM's basic kernel structure series. 

SOURCES=boot.o main.o

CFLAGS=-nostdlib -nostdinc -fno-builtin -fno-stack-protector 
LDFLAGS=-Tlink.ld
ASFLAGS=-felf

all: $(SOURCES) link 

clean:
	rm *.o kernel

link:
	ld $(LDFLAGS) -o kernel $(SOURCES)

.s.o:
	nasm $(ASFLAGS) $<
