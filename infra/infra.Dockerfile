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
RUN apt-get install -y build-essential

# Cmake 
RUN apt-get install -y cmake

# Proto compilers
RUN apt-get install -y libprotobuf-dev protobuf-compiler 

# Install nanopb 
RUN mv nanopb-0.4.7-linux-x86.tar.gz /opt
RUN cd /opt && tar -zxvf nanopb-0.4.7-linux-x86.tar.gz && \ 
    cd nanopb-0.4.7-linux-x86 && \ 
    mkdir build && cd build && \ 
    cmake .. && make && make install 

RUN rm -rf  nanopb-0.4.7-linux-x86.tar.gz  