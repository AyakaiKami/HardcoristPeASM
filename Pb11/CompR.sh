#!/bin/bash

nasm -f elf64 -o Pb11/pb11.o Pb11/pb11.asm
ld  Pb11/pb11.o -o Pb11/pb11
./Pb11/pb11