#!/usr/bin/env bash
sudo apt-get update && apt-get -y install python-software-properties
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository
sudo cp sources.list /etc/apt/
sudo apt-get update
apt-cache madison docker-ce
sudo apt-get install -y docker-ce
wget https://download.docker.com/linux/debian/dists/wheezy/pool/stable/amd64/docker-ce_18.03.1~ce-0~debian_amd64.deb
dpkg -i docker-ce_18.03.1~ce-0~debian_amd64.deb