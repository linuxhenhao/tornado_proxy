#!/bin/sh
docker rm -f scihub_container
docker rmi -f scihub

cd /root/tornado_proxy && git pull
pip install -r /root/tornado_proxy/requirements.txt
python /root/tornado_proxy/tornado_proxy/findmegoogleip.py &

cp /root/tornado_proxy/Dockerfile /root/docker/

cd /root
docker build -t scihub ./docker

docker run --name scihub_container -v /etc/letsencrypt/archive/scholar.thinkeryu.com/:/media/ -p 80:80 -p 443:443 scihub
