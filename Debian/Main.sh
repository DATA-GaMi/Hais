#!/usr/bin/env bash
source fun.sh
#Debian基础运行路径
export BASE_PATH=$PWD
#Python安装路径
export INSTALL_PATH=/usr/share/
release_num=$(lsb_release -rs)
release_type=$(lsb_release -is)

if [ "$release_type" == "Debian" ]
then
        echo -e "\033[32mDebian OS \033[1;0m"
        if [[ "$release_num" == 7.* ]] || [[ "$release_num" == 8.* ]] || [[ "$release_num" == 9.* ]] || [[ "$release_num" == 10* ]]
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
ps -fe | grep docker | grep -v grep
if [ $? -eq 0 ]
then
	echo "Docker服务正在运行."
elif [ "$release_type" = Debian ] && [[ "$release_num" == 7.* ]]; 
then
	bash OS-Version/Debian7.11/base.sh && bash OS-Version/Debian7.11/docker.sh;
    Docker-servicecheck
elif [ "$release_type" = Debian ] && [[ "$release_num" == 8.* ]]; 
then
	bash OS-Version/Debian8-newly/Ver-Schedule.sh && Docker-servicecheck
elif [ "$release_type" = Debian ] && [[ "$release_num" == 9.* ]]; 
then
	bash OS-Version/Debian9-newly/Ver-Schedule.sh && Docker-servicecheck
elif [ "$release_type" = Debian ] && [[ "$release_num" == 10* ]];  
then
	bash OS-Version/Debian10-newly/Ver-Schedule.sh && Docker-servicecheck
fi
echo -e "\033[36m基本组件已安装完成 \033[1;0m"

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
	Yes) . ./ContainerScript/Autoload.sh Tools-Image/* ;;
	No) echo -e "Shell ready to exit.\n exit.";exit 1;;
	esac
done