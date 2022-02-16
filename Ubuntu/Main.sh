#!/usr/bin/env bash
source fun.sh
#基础运行路径
export BASE_PATH=$PWD
#Python安装路径
export INSTALL_PATH=/usr/share/


release_num=$(lsb_release -rs)  #系统版本号
release_type=$(lsb_release -is) #系统类型信息

if [ "$release_type" = Ubuntu ]
then
	echo -e "\033[36mUbuntu OS \033[0m"
	if [[ $release_num == 14.04 ]] || [[ $release_num == 16.04 ]] || [[ $release_num == 18.04 ]] || [[ $release_num == 20.04 ]]
	then
		echo "System can install Docker"
	else
		echo "OS version error"
		exit 1
	fi
fi
echo "====================================="
echo "检查系统是否含有进程(Docker)           "
echo "====================================="
ps -fe | grep docker | grep -v grep
if [ $? -eq 0 ]
then
	echo "Docker服务正在运行."
elif [ "$release_type" == Ubuntu ] && [[ $release_num == 20.04 ]]; #2004
then
	bash OS-Version/Ubuntu2004/base.sh && Docker-servicecheck
elif [ "$release_type" == Ubuntu ] && [[ $release_num == 18.04 ]]; #1804
then
	bash OS-Version/Ubuntu1804/base.sh && Docker-servicecheck
elif [ "$release_type" == Ubuntu ] && [[ $release_num == 16.04 ]]; #1604
then
	bash OS-Version/Ubuntu1604/base.sh && Docker-servicecheck
elif [ "$release_type" == Ubuntu ] && [[ $release_num == 14.04 ]]; #1404
then
	bash OS-Version/Ubuntu1404/base.sh;bash OS-Version/Ubuntu1404/docker.sh && Docker-servicecheck
fi

#拉取Docker镜像
echo "=============================================="
echo "Docker Pull/Create Images/Containers              " 
echo "=============================================="
echo "启动相关镜像..."
echo -e "\033[36mDocker拉取镜像Portainer,并启动...  \033[0m"
bash ContainerScript/start-Portainer.sh

#加载CA证书设置
echo -e "\033[36m Loading CA script ... \033[0m"

python3 Extra/generate-certificate.py && bash Extra/cofmod.sh

#继续启动相关镜像
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

echo "当前所有基础镜像输出完成，是否加载工具镜像?"
select Choose in Yes No
do
	case $Choose in
	Yes) bash ContainerScript/Autoload.sh Tools-Image/* ;;
	No) echo -e "Shell ready to exit.\n exit.";exit 0 ;;
	esac
done







