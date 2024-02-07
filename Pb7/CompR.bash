#!/bin/bash

nasm -f elf64 -o Pb7/pb7.o Pb7/pb7.asm
ld Pb7/pb7.o -o Pb7/pb7
./Pb7/pb7