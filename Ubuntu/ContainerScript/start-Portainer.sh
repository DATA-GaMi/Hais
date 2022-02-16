#!/usr/bin/env bash
name="Portainer"

docker pull portainer/portainer
docker run -it -d -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock --name "$name" portainer/portainer:latest
#上面启动命令以及加载镜像需要配置好
sleep 4
Status=$(docker inspect -f '{{.State.Status}}' "$name")
if [ "$Status" = running ]
then
    echo -e "\033[32mCreate Portainer container successful! \033[0m" #Color is green
    echo -e "\033[31mNote:You must login Hostip:9000 to register your account after while docker's container is run. \033[0m" #Color is red
else
    echo -e "\033[31mError:Create Portainer container failed! \033[0m" #Color is red
fi