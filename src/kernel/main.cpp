#include "sys/console.h"

Console console;

void main(void) {
    console.clear();
    console.printf("Hello, world!", 0x07);
}

extern "C" void _loop(void) {
    try {
        main();
        while (1);
    } catch (const char* msg) {
        console.printf(msg, 0x04);
        while (1);
    }
}
