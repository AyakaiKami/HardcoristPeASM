#!/bin/bash

nasm -f elf64 -o Pb4/pb4.o Pb4/pb4.asm
ld Pb4/pb4.o -o Pb4/pb4
./Pb4/pb4