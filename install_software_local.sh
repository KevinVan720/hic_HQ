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
# python3.5+:
#	(use miniconda3)
# 	

# https://askubuntu.com/questions/865554/how-do-i-install-python-3-6-using-apt-get
# ubuntu14.04 repostory does not have python3.5+ registered
# use J Fernhough's PPA
# CAUTION: do not under any circumstances remove python3.4 by `sudo apt remove python3.4`
# python is fundamentally baked into ubuntu, and you could break your ubuntu install
# if you want python3 to map to python3.6, create a symlink instead!
#sudo add-apt-repository ppa:jonathonf/python-3.6
#sudo apt-get update
#sudo apt-get install python3.6

sudo apt-get update

# update to GCC 6 first
# python3 is more fundamentally baked into ubuntu, therefore we will deal with python in the end


# Err, using conda instead, install conda in silenet mode
wget https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/Miniconda3.sh
bash ~/Miniconda3.sh -b -p $HOME/miniconda3
export PATH="$HOME/miniconda3/bin:$PATH"
conda install -y numpy scipy h5py cython


sudo apt-get install cmake libboost-all-dev  libhdf5-serial-dev
sudo apt-get install gsl-bin libgsl0-dbg libgsl0-dev libgsl0ldbl

git clone --recursive https://github.com/Yingru/hic_HQ-osg.git
cd hic_HQ-osg
git checkout freestreaming
git submodule init
git submodule update
./makepkg
