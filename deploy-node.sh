apt update && apt dist-upgrade -y

apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install docker-ce docker-ce-cli containerd.io -y

/etc/init.d/docker start

docker ps

curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version

docker network create --driver=bridge shimmer

mkdir /opt/goshimmer

cp docker-compose.yml /opt/goshimmer/

cd /opt/goshimmer

mkdir db

chmod 0777 db 

docker-compose up -d

docker ps

docker logs -f --since=1m goshimmer


