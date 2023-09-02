MAGIC equ 0x1BADB002

section .multiboot
    dd MAGIC
    dd 0
    dd -MAGIC

section .bss
    stackBottom resb 8192

section .text
    global _start
    extern _loop

_start:
    mov esp, stackBottom + 8192
    call _loop

    cli
    hlt