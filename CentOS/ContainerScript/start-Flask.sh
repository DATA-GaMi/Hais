#!/usr/bin/env bash
name="Flask"

docker load -i Base-Image/flask*0.tar
docker run -dt -p 5000:5000 -v /tmp/input:/tmp/input --name "$name" flask:v2.0 /bin/bash -c "python3 /opt/flaskV2.0.py;tail -f /dev/null"#上面启动命令以及加载镜像需要配置好
sleep 4
Status=$(docker inspect -f '{{.State.Status}}' "$name")
if [ "$Status" = running ]
then
    echo -e "\033[32mCreate Flask container successful! \033[0m" #Color is green
else
    echo -e "\033[31mError:Create Flask container failed! \033[0m" #Color is red
fi