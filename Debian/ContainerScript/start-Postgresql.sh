#!/usr/bin/env bash
name="Postgresql"

docker pull postgres
docker run -it -d -p 15432:5432 -e POSTGRES_PASSWORD=123456 --name "$name" postgres:latest
#上面启动命令以及加载镜像需要配置好
sleep 4
Status=$(docker inspect -f '{{.State.Status}}' "$name")
if [ "$Status" = running ]
then
    echo -e "\033[32mCreate Postgresql container successful! \033[0m" #Color is green
else
    echo -e "\033[31mError:Create Postgresql container failed! \033[0m" #Color is red
fi
