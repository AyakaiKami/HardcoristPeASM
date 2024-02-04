#!/bin/bash

nasm -f elf64 -o Pb1/hello.o Pb1/hello.asm
ld Pb1/hello.o -o Pb1/hello
./Pb1/hello