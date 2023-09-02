# Compilers
ASM = nasm
CC = gcc

# Directories
SRC_DIR = src
BUILD_DIR = bin/build
BOOT_DIR = bin/boot

# Default build target

.DEFAULT_GOAL := all

# Targets

all: clean build

build:
	$(ASM) -f elf32 -o ./$(BUILD_DIR)/boot.o ./$(SRC_DIR)/main.asm
	$(CC) -m32 -c ./$(SRC_DIR)/kernel/main.cpp -o ./$(BUILD_DIR)/kernel.o -ffreestanding -O2 -Wall -Wextra 
	ld -m elf_i386 -T ./$(SRC_DIR)/linker.ld ./$(BUILD_DIR)/kernel.o ./$(BUILD_DIR)/boot.o -o ./$(BOOT_DIR)/AlveniaOS.elf -nostdlib
	grub-file --is-x86-multiboot ./$(BOOT_DIR)/AlveniaOS.elf
	grub-mkrescue -o ./$(BOOT_DIR)/kernel.iso ./bin

clean:
	rm -rf bin/build/*.o
	rm -rf bin/boot/*.elf
	rm -rf bin/boot/*.iso