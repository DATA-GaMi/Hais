#!/usr/bin/env bash

release_num=$(lsb_release -rs)
release_type=$(lsb_release -is)

base-env1()
{
    echo "Get the System Version..."
    echo "The system version is $release_type-$release_num"
    echo "检查更新...正在更新安装基本组件"
    sudo apt-get update
    sudo apt-get install -y vim curl git ssh wget software-properties-common yum python3-pip
}

Python-install()
{
    PS3="Python版本安装向导---->请选择安装的版本:" # 设置提示符字串.  
    echo
    select Version in 'Add deb source' 'Python2.7x(OS Default)' 'Python3.6(OS Default)' 'Python3.7' 'Python3.8' 'Pass'
    do
    	case $Version in
    	'Add deb source') sudo add-apt-repository ppa:deadsnakes/ppa;sudo apt-get update ;; 
    	'Python2.7x(OS Default)') sudo apt-get install -y python python-pip;python -m pip install --upgrade pip ;;
        'Python3.6(OS Default)') sudo apt-get install -y python3.6 python3-pip;python3 -m pip install --upgrade pip ;;
    	'Python3.7') sudo apt-get install -y python3.7* libpython3.7* python3-pip;python3 -m pip install --upgrade pip ;;
        'Python3.8') sudo apt-get install -y python3.8* libpython3.8*python3-pip;python3 -m pip install --upgrade pip ;;
        'Pass') echo "跳过";break ;;
    	esac
    done
}

modify()
{
        for i in /usr/bin/python3.?
        do
                update-alternatives --install /usr/bin/python3 python3 "$i" 1
        done
        update-alternatives --install /usr/bin/python3 python3 "$1" 2
        python3 -m pip install --upgrade pip
        pip -V && pip3 -V
}


Py-Pro()
{
    PS3="是否设置优先级?y/n:"
    echo
    select Choice in Yes No
    do  
	case $Choice in
	Yes) PS3="设置哪个Python3版本为优先使用?选择版本:"
		 echo ;
		select version in 'Python3.6(OS Default)' 'Python3.7' 'Python3.8' 'Exit'
		do
			case $version in
			'Python3.6(OS Default)') modify /usr/bin/python3.6 ;;
			'Python3.7') modify /usr/bin/python3.7;sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-36m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-37m-x86_64-linux-gnu.so ;;
			'Python3.8') modify /usr/bin/python3.8;sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-36m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-38-x86_64-linux-gnu.so ;;
			'Exit') echo "退出";break 2 ;;
			esac
		done;;
	No) echo "退出";break ;;
	esac
    done 
}


Docker-Setup()
{
    echo -e "\033[32m正在安装Docker...首先安装Docker相关依赖... \033[0m" # test
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    echo -e "\033[32m正在安装... \033[0m"
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
}