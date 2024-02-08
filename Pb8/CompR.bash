#!/bin/bash

nasm -f elf64 -o Pb8/pb8.o Pb8/pb8.asm
ld Pb8/pb8.o -o Pb8/pb8
./Pb8/pb8