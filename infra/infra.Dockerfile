# Base Image 
FROM ghcr.io/jimmy1977/gcc:0.0.0


# Defaults 
RUN apt-get update && \ 
    apt-get -y upgrade && \
    apt-get install -y git && \ 
    apt-get install -y vim && \ 
    apt-get install -y less coreutils

# Download nanppb 
RUN wget https://jpa.kapsi.fi/nanopb/download/nanopb-0.4.7-linux-x86.tar.gz

# Build essentials 
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  git \
  curl \
  vim \
  yasm \
  ca-certificates \
  apt-utils \
  libjpeg-dev \
  awscli \
  libpng-dev &&\
  rm -rf /var/lib/apt/lists/*


RUN apt-get update -qq && apt-get -y install \
  autoconf \
  automake \
  bc \
  bzip2 \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtheora-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  libx264-dev \
  libx265-dev \
  libmp3lame-dev \
  libopus-dev \
  libvpx-dev \
  aptitude \
  libssl-dev \
  mercurial \
  nasm \
  pkg-config \
  texinfo \
  wget \
  less \
  zlib1g-dev \
  net-tools \
  iputils-ping

# Cmake 
RUN apt-get install -y cmake

# A directory download the tools 
RUN mkdir /srv/tools 
RUN cd /srv/tools 

# Donwnload protocol buffers 
RUN cd /srv/tools && \
  wget https://github.com/protocolbuffers/protobuf/releases/download/v3.10.1/protobuf-cpp-3.10.1.tar.gz && \
  tar -zxf protobuf-cpp-3.10.1.tar.gz

RUN cd /srv/tools && \
  wget https://github.com/protobuf-c/protobuf-c/releases/download/v1.3.2/protobuf-c-1.3.2.tar.gz && \
  tar -zxf protobuf-c-1.3.2.tar.gz

RUN cd /srv/tools && \
  wget https://github.com/protocolbuffers/protobuf/releases/download/v3.10.1/protoc-3.10.1-linux-x86_64.zip && \
  unzip protoc-3.10.1-linux-x86_64.zip -d protoc-3.10.1

# Compile it for C++ and x86
RUN cd /srv/tools/protobuf-3.10.1 && \
  ./configure --prefix=/srv/tools/protobuf_x86_64 && \
  make -j$(grep -c ^processor /proc/cpuinfo) && \
  make check -j$(grep -c ^processor /proc/cpuinfo) && \
  make install -j$(grep -c ^processor /proc/cpuinfo)

# Proto compilers
RUN apt-get install -y libprotobuf-dev protobuf-compiler 

# Install python3 pip 
RUN apt-get install -y python3-pip 

# Install nanopb 
RUN cd /opt/ && wget https://github.com/nanopb/nanopb/archive/0.4.7.zip && unzip 0.4.7.zip && \
  cd /opt/nanopb-0.4.7/generator/proto && make && cd ../.. && \ 
  mkdir build && cd build && cmake .. && make && make install
RUN rm -rf /opt/0.4.7.zip

# Install protoc 
RUN cp /srv/tools/protoc-3.10.1/bin/protoc /usr/bin/protoc

# Install gtest 
RUN apt-get install -y sshpass libgtest-dev
RUN cd /usr/src/gtest && cmake CMakeLists.txt && \
    make && cp lib/* /usr/lib/ 

# Install clang format
RUN apt-get update && apt-get install -y clang-format