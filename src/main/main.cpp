#include "sys/console.h"

extern "C" void _mainW(void);
extern "C" void _loopW(void);

Console console;

extern "C" void _mainW(void) {
    console.clear();
    console.print("Hello, World!", 0x07);
}

extern "C" void _loopW(void) {
    _mainW();
    while(1);
}