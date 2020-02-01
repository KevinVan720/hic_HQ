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
RUN echo pwd
RUN git clone --recursive https://github.com/KevinVan720/hic_event

WORKDIR hic_HQ-osg/
RUN git checkout container
RUN git submodule update

RUN bash makepkg
RUN cp hic_HQ-osg.tar.gz /var

# run the events
WORKDIR /var
RUN tar -xzf hic_HQ-osg.tar.gz

WORKDIR /var/hic_HQ-osg/results
