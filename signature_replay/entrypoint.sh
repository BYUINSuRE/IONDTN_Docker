#!/bin/bash

# Compile the replay.c
echo "Compiling replay.c ..."

gcc replay.c -o replay \
    -I/usr/local/include \
    -I/ION-DTN/ici/include \
    -L/usr/local/lib -lams -lici -ldgr

ionadmin amroc.ionrc
amsd @ @ amsdemo test "" &
exec ./replay