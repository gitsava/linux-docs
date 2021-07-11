#! /bin/bash
# Referensi > https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-id

apt update
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt update
apt-cache policy docker-ce
apt install -y docker-ce
systemctl status docker