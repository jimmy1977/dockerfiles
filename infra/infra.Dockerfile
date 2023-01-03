# Base Image 
FROM ghcr.io/jimmy1977/gcc:0.0.0

# Defaults 
RUN apt-get update && \ 
    apt-get -y upgrade && \
    apt-get install -y git && \ 
    apt-get install -y vim

# Build essentials 
RUN apt-get install -y build-essential

# Cmake 
RUN apt-get install -y cmake

# Proto compilers
RUN apt-get install -y libprotobuf-dev protobuf-compiler 
