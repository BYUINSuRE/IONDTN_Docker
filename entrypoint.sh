#!/bin/bash
set -e

# Determine node identity based on container name
if [ "$HOSTNAME" = "node1" ]; then
    NODE_ID=1
    PEER_ID=2
    PEER_HOST=node2
elif [ "$HOSTNAME" = "node2" ]; then
    NODE_ID=2
    PEER_ID=1
    PEER_HOST=node1
else
    echo "Container must be named node1 or node2"
    exit 1
fi

PORT=4556

echo "Starting ION node $NODE_ID, peer = $PEER_HOST"

# --- ION config ---
cat <<EOF > ionrc
1 $NODE_ID ''
s
EOF

# --- BP config ---
cat <<EOF > bprc
1
a scheme ipn 'ipnfw' 'ipnadminep'
a endpoint ipn:$NODE_ID.1 q
a protocol udp 1400 100
a induct udp 0.0.0.0:$PORT udpcli
a outduct udp $PEER_HOST:$PORT udpclo
s
EOF

# --- Routing ---
echo "a plan $PEER_ID udp/$PEER_HOST:$PORT" > ipnrc

# --- Start ION ---
ionadmin ionrc
bpadmin bprc
ipnadmin ipnrc

echo "ION node $NODE_ID running"

# --- Start bpecho on Node 2 ---
# If this is node 2, start the echo daemon so node 1 can ping it
if [ "$NODE_ID" = "2" ]; then
    echo "Starting bpecho on ipn:2.1..."
    bpecho ipn:2.1 &
fi

# Keep container alive
tail -f /dev/null