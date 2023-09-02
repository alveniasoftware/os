#!/bin/sh

cd "$(dirname "$0")/.."

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

for i in xorriso grub-mkrescue nasm grub-file; do
    if ! command_exists "$i"; then
        echo "$i is not installed."
        exit 1
    fi
done

for i in dist bin bin/boot bin/boot/grub
do
    if [ ! -d "$i" ]; then
        mkdir "$i"
    fi
done

if [ ! -f "conf/grub.cfg" ]; then
    echo "conf/grub.cfg not found."
    exit 1
fi

cp conf/grub.cfg bin/boot/grub/grub.cfg