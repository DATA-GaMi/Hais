#!/usr/bin/env bash
source fun.sh
#CentOS基础运行路径
export BASE_PATH=$PWD
#Python安装路径
export INSTALL_PATH=/usr/share/

release_num=$(echo $(cat /etc/redhat-release | cut -c 21- | cut -c -4))
release_type=$(echo $(cat /etc/redhat-release | cut -c 1-6))
if [ "$release_type" == "CentOS" ]
then
        echo -e "\033[32m系统为CentOS \033[1;0m"
        if [[ "$release_num" == 6.* ]] || [[ "$release_num" == 7.* ]] || [[ "$release_num" == 8.* ]]
        then
                echo -e "\033[32mYour System can install Docker! \033[1;0m"
        else
                echo -e "\033[31mError \033[1;0m"
				exit 1
        fi
fi
echo "====================================="
echo "检查系统是否含有进程(Docker)           "
echo "====================================="
ps -fe | grep /usr/bin/dockerd | grep -v grep
if [ $? -eq 0 ]
then
	echo "Docker服务正在运行."
elif [ "$release_type" == "CentOS" ] && [[ "$release_num" == 6.* ]]; 
then
	bash OS-Version/CentOS6-6.10/Ver-Choice.sh && Docker-servicecheck
elif [ "$release_type" == "CentOS" ] && [[ "$release_num" == 7.* ]]; 
then
	bash OS-Version/CentOS7-7.7/Ver-Choice.sh && Docker-servicecheck
elif [ "$release_type" == "CentOS" ] && [[ "$release_num" == 8.* ]]; 
then
	bash OS-Version/CentOS8-8.1/Ver-Choice.sh && Docker-servicecheck
else
	echo "error"
fi
#拉取Docker镜像
echo "=============================================="
echo "Docker Pull/Create Images/Containers              " 
echo "=============================================="
echo "启动相关镜像..."
echo -e "\033[36mDocker拉取镜像Portainer,并启动...  \033[0m"
bash ContainerScript/start-Portainer.sh
echo -e "\033[36m Loading CA script ... \033[0m"
python3 Extra/generate-certificate.py && bash Extra/cofmod.sh
echo -e "\033[36mDocker拉取镜像Postgresql,并启动... \033[0m"
bash ContainerScript/start-Postgresql.sh
echo -e "\033[36mDocker拉取镜像MongoDB,并启动...    \033[0m"
cd ContainerScript/Mongo-Cluster/ || return
pwd
bash start-MongoDB.sh
pwd

echo -e "\033[36m启动Flask镜像...  \033[0m"
bash ContainerScript/start-Flask.sh
echo -e "\033[36m启动Cooper镜像... \033[0m"
bash ContainerScript/start-SwintVAS.sh

PS3="当前所有基础镜像输出完成，是否加载工具镜像?"
echo
select Choose in Yes No
do
	case $Choose in
	Yes) bash ContainerScript/Autoload.sh Tools-Image/* ;;
	No) echo -e "Shell ready to exit.\n exit.";exit 0;;
	esac
done