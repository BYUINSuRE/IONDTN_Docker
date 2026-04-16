FROM ubuntu:24.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive

# Grabs all the dependencies needed for ION-DTN
RUN apt-get update && apt-get install -y \
    build-essential automake autoconf libtool m4 \
    cmake pkg-config git libssl-dev libjansson-dev ninja-build \
    rsync valgrind ruby

# Grabs ION-DTN from Github, on branch with BSL enabled
# Also initializes and updates all submodules
RUN git clone --branch ion-open-source-4.2.0-a.1 --recurse-submodules \
    https://github.com/nasa-jpl/ION-DTN.git

# Build and install ION with BSL
WORKDIR /ION-DTN
RUN autoreconf -fi
RUN ./configure --enable-bsl
RUN make -j$(nproc)
RUN make install
RUN ldconfig

# Now run the tests
WORKDIR /ION-DTN/tests/signature_replay

CMD ["./dotest", "signature_replay"]