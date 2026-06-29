#!/bin/bash

module_name="amshello"

# Compile the program (commands from AMS programmer's guide)
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

# Start AMS
echo "Starting AMS..."
amsd @ @ amsdemo test "" &
sleep 3

echo "Running program..."
./amshello

echo "Cleaning up..."
rm $module_name $module_name.o

echo "--- ION log ---"
cat ion.log
