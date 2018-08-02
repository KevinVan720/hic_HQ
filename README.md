# hic_HQ
 A framework of heavy quark evolution in heavy-ion collisions


## to build a `Docker` container from *Dockerfile*
```
# build the docker image
sudo docker build -t hic_hq:v1 .
cd workdir/

# to run the executable
sudo docker run -v `pwd`:/tmp/hic_HQ-osg/results hic_hq:v2 python3 run-events_cD.py args.conf 0
```

