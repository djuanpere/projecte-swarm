apt install -y git
#instalar docker
curl https://get.docker.com | sudo bash

mkdir -p /srv/docker
mkdir -p /srv/nfs
#	Configurar NFS
echo 'node-1:/srv/nfs /srv/docker nfs defaults,nfsvers=3 0 0' >> /etc/fstab
apt install -y nfs-kernel-server
echo '/srv/nfs 10.132.0.0/24(rw,no_root_squash,no_subtree_check)' >> /etc/exports
systemctl start nfs-kernel-server
exportfs -r
mount -a

#creació cluster swarm
docker swarm init 
docker swarm join-token manager|grep join  > /srv/docker/join.sh
chmod +x !$

cd /srv/docker
git clone https://github.com/djuanpere/projecte-swarm

mkdir -p /srv/docker/portainer/portainer/data
mkdir -p /srv/docker/elasticsearch/data
chmod 1777 /srv/docker/elasticsearch/data
mkdir -p /srv/docker/logstash/config
cp /srv/docker/swarm-cluster-example/logspout-elk/files/logstash.conf /srv/docker/logstash/config/

docker network create proxy -d overlay
docker network create portainer_agent -d overlay
docker network create backend -d overlay


