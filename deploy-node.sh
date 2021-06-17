# Script for deploy IOTA 2.0 nodes
# By Ubiot
#
# Instance requirements:
# - 2 cores / 4 threads
# - 4 GB of memory
# - 40 GB of disk space
#
# Required inbounds rules:
# - 14626	Autopeering	UDP
# - 14666	Gossip		TCP
# - 10895	FPC		TCP/HTTP
# - 8080	HTTP API	TCP/HTTP
# - 8081	Dashboard	TCP/HTTP
# - 6061	pprof HTTP API	TCP/HTTP
#
# Reference:
# https://goshimmer.docs.iota.org/tutorials/setup.html

# Lets first upgrade the packages on our system
apt update && apt dist-upgrade -y

# Install needed dependencies
apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common -y

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add the actual repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the package index
apt-get update

# And finally, install docker
apt-get install docker-ce docker-ce-cli containerd.io -y

# On windows-subsystem for Linux (WSL2) it may be necessary to start docker seperately
/etc/init.d/docker start

# Check whether docker is running by executing
docker ps

# Download docker compose
curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make it executable
chmod +x /usr/local/bin/docker-compose

# Check that docker compose works
docker-compose --version

# Lets create a user defined bridged network
docker network create --driver=bridge shimmer

# Lets create a folder holding our docker-compose.yml
mkdir /opt/goshimmer

# Copy the downloaded format to our new folder and cd to it
cp docker-compose.yml /opt/goshimmer/

cd /opt/goshimmer

# Lets create a folder holding our database

mkdir db

# Give permissions
chmod 0777 db 

# Running the GoShimmer node
docker-compose up -d

# You should see your container running now
docker ps

# You can follow the log output of the node via
docker logs -f --since=1m goshimmer
