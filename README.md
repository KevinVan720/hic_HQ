# hic_HQ
 A framework of heavy quark evolution in heavy-ion collisions



- [1. Work with cloud computing system [**Chameleon**](https://www.chameleoncloud.org/)](#1-work-with-cloud-computing-system----chameleon----https---wwwchameleoncloudorg--)
    * [1.1 Install `Docker` in Chemeleon instance](#11-install--docker--in-chemeleon-instance)
    * [1.2 to build a `Docker` container from *Dockerfile*](#12-to-build-a--docker--container-from--dockerfile-)



## 1. Work with cloud computing system [**Chameleon**](https://www.chameleoncloud.org/)
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

### 1.1 Install `Docker` in Chemeleon instance
```
ssh cc@192.5.87.168

# check OS version
lsb_release -a

# install docker and its dependencies
# 1. you can use the default installation, such as apt-get to install from OS repository
# 2. install from source (17.03.2 version)
sudo apt-get install libsystemd-journal0
wget https://download.docker.com/linux/ubuntu/dists/trusty/pool/stable/amd64/docker-ce_17.03.2~ce-0~ubuntu-trusty_amd64.deb
sudo dpkg -i docker-ce_17.03.2~ce-0~ubuntu-trusty_amd64.deb
```


### 1.2 to build a `Docker` container from *Dockerfile*
```
# build the docker image
git clone https://github.com/Yingru/hic_HQ.git
cd hic_HQ/
sudo docker build -t hic_hq:v1 .
cd workdir/

# to run the executable
# run-events_cD.py is the pipeline script
# args.conf changes the parameters ($alpha_s, \hat{q}_{min}, \hat{q}_{slope}, \gamma$
# 0 is the jobID (useful to run parallel events)
sudo docker run -v `pwd`:/tmp/hic_HQ-osg/results hic_hq:v2 python3 run-events_cD.py args.conf 0
```

