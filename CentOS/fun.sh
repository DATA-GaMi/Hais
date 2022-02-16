#!/usr/bin/env bash
#安装完成再次检查Docker服务
Docker-servicecheck()
{
    echo "===================================="
    echo "再次检查系统是否含有Docker           " 
    echo "===================================="
    ps -fe | grep /usr/bin/dockerd | grep -v grep
    if [ $? -eq 0 ]
    then
    	echo -e "\033[32m安装完成 \033[1;0m"
    else
    	echo "Docker安装失败.Please install Docker Service by other ways."
    	exit 1
    fi
}