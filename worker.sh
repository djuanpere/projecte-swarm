#run by hand next two lines
#apt install -y git
#curl https://get.docker.com | sudo bash

mkdir -p /srv/docker
#Configurar NFS
echo 'maquina-4:/srv/nfs /srv/docker nfs defaults,nfsvers=3 0 0' >> /etc/fstab
apt install -y nfs-common
echo '/srv/nfs 10.132.0.5/32(rw,no_root_squash,no_subtree_check)' >> /etc/exports
mount -a
chmod 775 /srv/docker/join.sh
/srv/docker/join.sh

