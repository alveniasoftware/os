import os, sys, subprocess, shutil, shared

grubcfg = """set timeout="0"
set default="0"

menuentry "AlveniaOS" {
	multiboot /boot/AlveniaOS.elf
}
"""

sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

for i in ["xorriso", "grub-mkrescue", "grub-file", "ld", "gcc", "nasm"]:
    if not shared._command_exists(i):
        print(f"Command not found: {i}")
        sys.exit(1)
    
for i in ["bin", "bin/boot", "bin/boot/grub", "dist"]:
    if not os.path.exists(i):
        os.mkdir(i)

if not os.path.exists("conf/grub.cfg"):
    with open("bin/boot/grub/grub.cfg", "w") as f:
        f.write(grubcfg)
else:
    shutil.copyfile("conf/grub.cfg", "bin/boot/grub/grub.cfg")

print("Completed! Check the wiki for more information.")