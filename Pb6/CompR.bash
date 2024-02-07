#!/bin/bash
nasm -f elf64 Pb6/pb6.o -o Pb6/pb6.asm
ld  Pb6/pb6.o -o Pb6/pb6
./Pb6/pb6