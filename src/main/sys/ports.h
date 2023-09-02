#pragma once

void port_outb(unsigned short port, unsigned char data)
{
    asm volatile("outb %0, %1" : : "a"(data), "Nd"(port));
}

void port_outw(unsigned short port, unsigned short data)
{
    asm volatile("outw %0, %1" : : "a"(data), "Nd"(port));
}

unsigned char port_inb(unsigned short port)
{
    unsigned char data;
    asm volatile("inb %1, %0" : "=a"(data) : "Nd"(port));
    return data;
}

unsigned short port_inw(unsigned short port)
{
    unsigned short data;
    asm volatile("inw %1, %0" : "=a"(data) : "Nd"(port));
    return data;
}