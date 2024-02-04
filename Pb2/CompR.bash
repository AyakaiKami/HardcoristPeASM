#!/bin/bash

nasm -f elf64 -o Pb2/pb2.o Pb2/pb2.asm
ld Pb2/pb2.o -o Pb2/pb2
./Pb2/pb2