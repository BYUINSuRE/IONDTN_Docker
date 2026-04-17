#!/bin/bash

# Compile the replay.c
echo "Compiling replay.c ..."

gcc replay.c -o replay \
    -I/usr/local/include \
    -I/ION-DTN/ici/include \
    -L/usr/local/lib -lams -lici -ldgr

echo "Starting ION..."
ionadmin amroc.ionrc
sleep 1

echo "Configuring BP..."
bpadmin amroc.bprc
sleep 1

echo "Starting AMS..."
amsd @ @ amsdemo test "" &
sleep 3

echo "Running program..."
exec ./replay

echo "Finished running..."