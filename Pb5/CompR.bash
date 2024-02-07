#!/bin/bash

nasm -f elf64 -o Pb5/pb5.o Pb5/pb5.asm
ld Pb5/pb5.o -o Pb5/pb5
./Pb5/pb5