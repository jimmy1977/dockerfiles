FROM ghcr.io/jimmy1977/gcc:0.0.0
RUN apt-get update && \ 
    apt-get -y upgrade && \
    apt-get install -y git && \ 
    apt-get install -y vim

RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y libprotobuf-dev protobuf-compiler 
