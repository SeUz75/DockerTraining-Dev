FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Base system + build essentials
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    gawk \
    git \
    wget \
    unzip \
    rsync \
    file \
    diffstat \
    chrpath \
    socat \
    cpio \
    xz-utils \
    iputils-ping \
    util-linux \
    uuid-dev \
    zstd \
    liblz4-tool \
    ca-certificates \
    ssh \
    fakeroot \
    fakechroot \
    libselinux1-dev \
    libpam0g-dev \
    libiberty-dev \
    binutils-dev \
    libarchive-dev \
    libxml2-utils \
    libxml-simple-perl \
    xmlstarlet \
    texinfo \
    flex \
    bison \
    libyaml-dev \
    libtinfo5 \
    libwayland-dev \
    libegl1-mesa \
    libsdl1.2-dev \
    clang \
    xterm \
    openjdk-8-jdk-headless \
    qemu-user-static \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Python 2.7 (PRIMARY – legacy build scripts)
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository universe \
    && apt-get update \
    && apt-get install -y \
       python \
       python-dev \
       python-pip \
    && rm -rf /var/lib/apt/lists/*

# Enforce python == python2
RUN ln -sf /usr/bin/python2 /usr/bin/python && \
    ln -sf /usr/bin/pip2 /usr/bin/pip

# ------------------------------------------------------------
# Python 3 (SECONDARY – modern tooling)
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create it outside the app folder
RUN python3 -m venv /opt/venv

RUN pip

# Force the system to use this venv by default
ENV PATH="/opt/venv/bin:$PATH"


# ------------------------------------------------------------
# Working directory
# ------------------------------------------------------------
WORKDIR /work
