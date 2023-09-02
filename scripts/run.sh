ASMC="nasm"
ASMC_FLAGS="-f elf32"

CC="gcc"
CC_FLAGS="-m32 -c -ffreestanding -O2 -Wall -Wextra"

LD_FLAGS="-m elf_i386"

SRC_DIR="src"
BUILD_DIR="dist"
BIN_DIR="bin"

OS_NAME="AlveniaOS"

DEFAULT_GOAL="all"

all() {
    clean
    build
}

build() {
    $ASMC $ASMC_FLAGS -o "$BUILD_DIR/boot.o" "$SRC_DIR/main.asm"
    $CC $CC_FLAGS "$SRC_DIR/main/main.cpp" -o "$BUILD_DIR/kernel.o"
    ld $LD_FLAGS -T "$SRC_DIR/linker.ld" "$BUILD_DIR/kernel.o" "$BUILD_DIR/boot.o" -o "$BIN_DIR/boot/$OS_NAME.elf" -nostdlib
    grub-file --is-x86-multiboot "$BIN_DIR/boot/$OS_NAME.elf"
    grub-mkrescue -o "$OS_NAME.iso" $BIN_DIR
}

clean() {
    rm -rf "$BUILD_DIR"/*.o
    rm -rf "$BIN_DIR/boot"/*.elf
    rm $OS_NAME.iso
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

for i in xorriso $ASMC grub-mkrescue grub-file ld $CC; do
    if ! command_exists "$i"; then
        echo "$i is not installed."
        exit 1
    fi
done

for i in "$BUILD_DIR" "$BIN_DIR/boot" "$BIN_DIR/boot/grub"; do
    if [ ! -d "$i" ]; then
        mkdir "$i"
    fi
done

case "$1" in
    all)
        all
        ;;
    build)
        build
        ;;
    clean)
        clean
        ;;
    *)
        echo "Usage: $0 (all|build|clean)"
        exit 1
esac

echo "Completed!"
exit 0
