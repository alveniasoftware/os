/*
void console_init();
void printf(const char *str, char color);
void clear();

char* buffer = reinterpret_cast<char*>(0xb8000);
int x = 0; 
int y = 0; 
int max = 25;

void console_init() {
    clear();
}

void printf(const char *str, char color) {
    int i = 0;
    while (str[i] != '\0') {
        buffer[(y * 80 + x) * 2] = str[i];
        buffer[(y * 80 + x) * 2 + 1] = color;
        x++;
        if (x >= 80) {
            x = 0;
            y++;
        }
        if (y >= max) {
            y = 0;
        }
        i++;
    }
}

void clear() {
    int i = 0;
    while (i < 80 * max * 2) {
        buffer[i] = ' ';
        buffer[i + 1] = 0x07;
        i += 2;
    }
    x = 0;
    y = 0;
}

class Console {
public:
    Console() {
        console_init();
    }

    void printf(const char *str, char color) {
        ::printf(str, color);
    }

    void clear() {
        ::clear();
    }
};
*/

#include "ports.h"

void print(const char* str, const char color);
void printf(const char* str, const char color);
void move_cursor(unsigned short pos);
void clear();

char* buffer = reinterpret_cast<char*>(0xb8000);
int x = 0;
int y = 0;

void print(const char* str, const char color) {
    int i = 0;
    while (str[i] != '\0') {
        buffer[(y * 80 + x) * 2] = str[i];
        buffer[(y * 80 + x) * 2 + 1] = color;
        x++;
        if (x >= 80) {
            x = 0;
            y++;
        }
        if (y >= 25) {
            y = 0;
        }
        i++;
        
        move_cursor(y * 80 + x);
    }
}

void move_cursor(unsigned short pos) {
    port_outb(0x3d4, 0x0f);
    port_outb(0x3d5, (unsigned char)(pos & 0xff));
    port_outb(0x3d4, 0x0e);
    port_outb(0x3d5, (unsigned char)((pos >> 8) & 0xff));
}

void clear() {
    int i = 0;
    while (i < 80 * 25 * 2) {
        buffer[i] = ' ';
        buffer[i + 1] = 0x07;
        i += 2;
    }
    x = 0;
    y = 0;
}

class Console {
public:
    Console() {
        clear();
    }

    void print(const char* str, const char color) {
        ::print(str, color);
    }

    void clear() {
        ::clear();
    }
};