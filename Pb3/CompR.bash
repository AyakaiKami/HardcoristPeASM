#!/bin/bash

nasm -f elf64 -o Pb3/pb3.o Pb3/pb3.asm
ld Pb3/pb3.o -o Pb3/pb3
./Pb3/pb3