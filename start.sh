#!/bin/bash

IP1=$1
IP2=$2
IP3=$3
export IP1 IP2 IP3
export REMOTE_MOUNT="/srv/docker/data"

cd /root/projecte-swarm
docker stack deploy -c traefik/stack.yaml traefik
docker stack deploy -c portainer/stack.yaml portainer
docker stack deploy -c consul-cluster/stack.yaml consul-cluster
docker stack deploy -c comptador/stack.yaml comptador
docker stack deploy -c wordpress/stack.yaml wp
docker stack deploy -c logspout-elk/stack.yaml logspout-elk
