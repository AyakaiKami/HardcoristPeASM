#!/bin/bash

nasm -f elf64 -o Pb9/pb9.o  Pb9/pb9.asm
ld Pb9/pb9.o -o Pb9/pb9
./Pb9/pb9