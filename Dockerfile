FROM ubuntu:14.04
MAINTAINER yx59@duke.edu

ENV PACKAGES git make gcc g++ gfortran cmake \
            libboost-all-dev libhdf5-serial-dev \
            gsl-bin libgsl0-dbg libgsl0-dev libgsl0ldbl \
            python3 python3-h5py python3-numpy python3-scipy python3-pip 

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${PACKAGES}
    
RUN pip3 install fortranformat


# Install hic_HQ-osg
RUN git clone --recursive https://github.com/Yingru/hic_HQ-osg.git

WORKDIR hic_HQ-osg/
RUN bash makepkg
RUN cp hic_HQ-osg.tar.gz /tmp

# run the events
WORKDIR /tmp
RUN tar -xzf hic_HQ-osg.tar.gz

WORKDIR /tmp/hic_HQ-osg
