#!/usr/bin/env bash
echo "正在安装Docker..." # test
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache madison docker-ce
sudo apt-get install -y docker* container.io
systemctl enable docker
docker -v