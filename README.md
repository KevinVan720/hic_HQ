# hic_HQ
 A framework of heavy quark evolution in heavy-ion collisions

- [0. Work locally (make sure you have root right)](#0-work-locally--make-sure-you-have-root-right-)
- [1. Work with cloud computing system](#1-work-with-cloud-computing-system)
  * [1.1 Install `Docker` in Chemeleon instance](#11-install--docker--in-chemeleon-instance)
  * [1.2a Build a `Docker` container from *Dockerfile*](#12a-build-a--docker--container-from--dockerfile-)
  * [1.2b Instead of 1.2a, pull a `Docker` image from *dockerhub*](#12b-instead-of-12a-pull-a--docker--image-from--dockerhub-)


## 0. Work locally (make sure you have root right)
```
git clone https://github.com/Yingru/hic_HQ.git

cd hic_HQ/
bash install_software.sh  # returns a tar.gz file where contains all the modules


mkdir test
cp hic_HQ-osg/hic_HQ-osg.tar.gz test/
cd test/
tar -xzf hic_HQ-osg.tar.gz
cp -r ../workdir/ hic_HQ-osg
cd hic_HQ-osg/workdir


python3 python3 run-events_cD.py args.conf 0
# args.conf set up parameters ($\alpha_s, \hat{q}_{min}, \hat{q}_{slope}, \gamma$)
# parameter_df.dat are diffusion parameters (particle_ID, hydro_ID, HQ list ...)
# parameter_hd.dat are hadronization parameters (particle_ID ...)
# HQ_sample.conf are initially sample HQ list parameters
# vishnew.conf are hydro parameters (shear, bulk, edensity ...)
# 0 is jobID, useful when you run parallel jobs
```

## 1. Work with cloud computing system 

[**Chameleon**](https://www.chameleoncloud.org/)
- [tutorial, get started]((https://chameleoncloud.readthedocs.io/en/latest/getting-started/index.html)
- Create an account, join/create a project 
- Loggin in through [UChicago](https://chi.uc.chameleoncloud.org/) or [TACC](https://chi.tacc.chameleoncloud.org/)
- Reserve a node, launch instance (I choosed **Ubuntu14.04**), create a key pair, associate IP address
- access your instance
```
# download the .pem key pair
chmod 600 yx59chameleonkey.pem
ssh-add yx59chameleonkey.pem
ssh cc@ip_address
```

### 1.1 Install `Docker` in Chameleon instance
```
ssh cc@192.5.87.178

# check OS version
lsb_release -a

# install docker and its dependencies
# 1. you can use the default installation, such as apt-get to install from OS repository
# 2. install from source (17.03.2 version)

mkdir Install && cd Install
sudo apt-get install libsystemd-journal0
wget https://download.docker.com/linux/ubuntu/dists/trusty/pool/stable/amd64/docker-ce_17.03.2~ce-0~ubuntu-trusty_amd64.deb
sudo dpkg -i docker-ce_17.03.2~ce-0~ubuntu-trusty_amd64.deb
```


### 1.2a Build a `Docker` container from *Dockerfile*
```
# build the docker image
git clone https://github.com/Yingru/hic_HQ.git
cd hic_HQ/
sudo docker build -t hic_hq:v1 .

# check docker images
sudo docker images
cd workdir/

# to run the executable
# run-events_cD.py is the pipeline script
# args.conf changes the parameters ($alpha_s, \hat{q}_{min}, \hat{q}_{slope}, \gamma$
# 0 is the jobID (useful to run parallel events)
sudo docker run -v `pwd`:/var/hic_HQ-osg/results hic_hq:v1 python3 run-events_cD.py args.conf 0
```

### 1.2b Instead of 1.2a, pull a `Docker` image from *dockerhub*
```
# distinguish from previous case, dockerhub autimatically assign tag as latest
sudo docker pull yingruxu/hic_hq:latest
sudo docker images
cd workdir/
sudo docker run -v `pwd`:/var/hic_HQ-osg/results yingruxu/hic_hq:latest python3 run-events_cD.py args.conf 1

```


### 1.3 Install `singularity` in Chameleon instance
```
#singularity dependencies
sudo apt-get update
sudo apt-get install libarchive-dev python dh-autoreconf build-essential

# install the maste branch
git clone https://github.com/singularityware/singularity.git
cd singularity

# ERRRR, their master branch is not consistent with tutorial!
git checkout vault/release-2.5

./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
```


### 1.3a Pull `singularity` container from `dockerhub` <font color='red'> currently broken! need to fix </font>
```
# check version, better use 2.5.2 (for some reason, the older version 2.3 doesn't pull)
singularity --version

cd workdir/
sudo apt-get update && sudo apt-get install squashfs-tools 
singularity pull docker://yingruxu/hic_hq

# convert this to a writable container
singularity build --writable hic_hq_write.img hic_hq.simg

# or build from dockerhub (not sure what is the difference)
singularity build --writable hic_hq_write.img docker://yingruxu/hic_hq


# doesn't work? read-only filesystem? I am not able to write? -- fixed
# now the second question, not enough space
sudo singularity shell --writable -B $PWD:/var/hic_HQ-osg/results hic_hq_write.img
cd /var/hic_HQ-osg/results/
# for some reason need to set locale?
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

python3 run-events_cD.py args.conf 0
```


### 1.3b Or instead 1.3a, build `singularity` image from recipe
```
# remember to build writable image
sudo singularity build --writable hic_hq.img Singularity

# to test singularity container interactively
sudo singularity shell --writable -B $PWD:/var/hic_HQ-osg/results hic_hq.img

```
