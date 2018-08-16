#!/bin/bash

# notes for package dependencies, the following version has been tested
# gnu compilers:
# 	gcc/gfortran/g++ --version >> 4.8.4
# cmake:
#	cmake --version  >> 2.8.12.2
# boost:
#	libboost-all-dev   
#	dpkg -s libboost-all-dev | grep 'Version' >> 1.54.0.1ubuntu1
# hdf5:
#	libhdf5-serial-dev
#	dpkg -s libhdf5-serial-dev | grep 'Version' >> 1.8.11-5ubuntu7
# gsl:
# 	gsl-bin libgsl0-dbg libgsl0-dev libgsl0ldbl
#	dpkg -s libgsl0-dev | grep 'Version' >> 1.16+dfsg-1ubuntu1


sudo apt-get update && \
	sudo apt-get install python3 python3-h5py python3-numpy python3-scipy python3-pip 
sudo pip install fortranformat

sudo apt-get install cmake libboost-all-dev  libhdf5-serial-dev
sudo apt-get install gsl-bin libgsl0-dbg libgsl0-dev libgsl0ldbl

git clone --recursive https://github.com/Yingru/hic_HQ-osg.git
cd hic_HQ-osg
git checkout container
git submodule update
./makepkg
