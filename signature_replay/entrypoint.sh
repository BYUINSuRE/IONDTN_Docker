#!/bin/bash

module_name="replay"

# Compile the program
echo "Compiling $module_name.c ..."

gcc -g -Wall -Werror -Dlinux -DUDPTS -DTCPTS -DDGRTS -DNOEXPAT -fPIC -DSPACE_ORDER=3 \
    -I/ION-DTN/ams/library -I/ION-DTN/ams/include -I/ION-DTN/ams/rams -I/usr/local/include -I/ION-DTN/ici/include \
    -c $module_name.c

gcc -g -Wall -Werror -Dlinux -DUDPTS -DTCPTS -DDGRTS -DNOEXPAT -fPIC -DSPACE_ORDER=3 \
    -I/ION-DTN/ams/library -I/ION-DTN/ams/include -I/ION-DTN/ams/rams -I/usr/local/include -I/ION-DTN/ici/include \
    -o $module_name $module_name.o -L./lib -L/usr/local/lib -lams -ldgr -lici -lpthread

# Start ION
echo "Starting ION..."
ionadmin amroc.ionrc
sleep 1

# echo "Configuring BP..."
# bpadmin amroc.bprc
# sleep 1

# Start AMS
echo "Starting AMS..."
amsd @ @ amsdemo test "" &
sleep 3

echo "Running program..."
./replay

echo "Cleaning up..."
rm replay replay.o

echo "--- ION log ---"
cat ion.log
rm ion.log