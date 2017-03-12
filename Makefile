
TARGET=os.bin

all	: boot.asm kernel.asm
	nasm -f bin -o boot.bin boot.asm
	nasm -f bin -o kernel.bin kernel.asm
	cat boot.bin kernel.bin > os.bin

run :
	qemu.exe ${TARGET}
