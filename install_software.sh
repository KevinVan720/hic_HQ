#!/bin/bash

git clone --recursive https://github.com/Yingru/hic_HQ-osg.git

sudo apt-get install cmake libboost-all-dev  libhdf5-serial-dev
sudo apt-get install python3 python3-h5py python3-numpy python3-scipy python3-pip
sudo apt-get install gsl-bin libgsl0-dbg libgsl0-dev libgsl0ldbl
sudo pip3 install fortranformat

# cmake --version
# 2.8.12.2

# boost version
# dpkg -s libboost-dev | grep 'Version'
# 1.54.0.1ubuntu1

# hdf5 version
# libhdf5-serieal-dev installl C, C++ and Fortran version of the library
# libhdf5-cpp-11 only provided by ubuntu 16

# GSL library
# gsl-bin  libgsl0-dbg  libgsl0-dev libgsl0ldbl
