# Build version and types
FROM ubuntu:22.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive

# Grabs all the dependencies needed for ion/dtn
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    autoconf \
    automake \
    libtool \
    libssl-dev \
    tcl-dev \
    # ca-certificates \
    # perl \
    && rm -rf /var/lib/apt/lists/*

# Grabs ION from github and stores it in the tmp directory
WORKDIR /tmp
RUN git clone https://github.com/nasa-jpl/ION-DTN.git
WORKDIR /tmp/ION-DTN


# Try to checkout the specific tag, fallback to master if the tag format changed
RUN git checkout ion-open-source-4.1.4 || git checkout master 


RUN autoreconf -i && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Runtime Stage
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libssl3 \
    tcl \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local /usr/local
RUN ldconfig

WORKDIR /ion
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]