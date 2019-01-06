FROM ubuntu:18.04

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git mercurial graphviz \
xdot pkg-config python python3 libftdi-dev ca-certificates usbutils

WORKDIR /tmp

RUN git clone https://github.com/cliffordwolf/icestorm.git && cd icestorm && make -j 8 && make install && rm -rf ../icestorm
RUN git clone https://github.com/cseed/arachne-pnr.git && cd arachne-pnr && make -j 8 && make install && rm -rf ../arachne-pnr
RUN git clone https://github.com/cliffordwolf/yosys.git && cd yosys && make -j 8 && make install && rm -rf ../yosys

RUN mkdir -p /external
WORKDIR /external

CMD bash
