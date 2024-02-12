#!/bin/bash

nasm -f elf64 -o Pb10/pb10.o Pb10/pb10.asm
ld Pb10/pb10.o -o Pb10/pb10
./Pb10/pb10