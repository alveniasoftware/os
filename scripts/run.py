import os, sys, subprocess, shared

ASMC = "nasm"
ASMC_FLAGS = "-f elf32"

CC = "gcc"
CC_FLAGS = "-m32 -c -ffreestanding -O2 -Wall -Wextra"

LD_FLAGS = "-m elf_i386"

SRC_DIR = "src"
BUILD_DIR = "dist"
BIN_DIR = "bin"

OS_NAME = "AlveniaOS"

DEFAULT_GOAL = "all"

sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

def _clean():
    try: 
        for f in os.listdir(BUILD_DIR):
            os.remove(os.path.join(BUILD_DIR, f))
        
        os.remove(f"{OS_NAME}.iso")
    except FileNotFoundError:
        pass

def _build():
    os.system(f"{ASMC} {ASMC_FLAGS} {SRC_DIR}/main.asm -o {BUILD_DIR}/boot.o")
    os.system(f"{CC} {CC_FLAGS} {SRC_DIR}/main/main.cpp -o {BUILD_DIR}/kernel.o")
    os.system(f"ld {LD_FLAGS} -T {SRC_DIR}/linker.ld {BUILD_DIR}/boot.o {BUILD_DIR}/kernel.o -o {BIN_DIR}/boot/{OS_NAME}.elf")
    os.system(f"grub-file --is-x86-multiboot {BIN_DIR}/boot/{OS_NAME}.elf")
    os.system(f"grub-mkrescue -o {OS_NAME}.iso {BIN_DIR}")

args = sys.argv[1:]

for i in ["xorriso", "grub-mkrescue", "grub-file", "ld", "gcc", "nasm"]:
    if not shared._command_exists(i):
        print(f"Command not found: {i}")
        sys.exit(1)

if len(args) == 0:
    args.append(DEFAULT_GOAL)

if "clean" in args:
    _clean()
elif "build" in args:
    _build()
else:
    print(f"Unknown command: {args[0]}")
    sys.exit(1)