#!/usr/bin/env bash



release_num=$(lsb_release -r --short)
release_type=$(lsb_release -i --short)

base-env1()
{
    echo "Get the System Version..."
    echo "The system version is $release_type-$release_num"
    echo "检查更新...正在更新安装基本组件"
    sudo apt-get update
    sudo apt-get install -y vim curl git wget ssh software-properties-common yum
    sudo systemctl enable ssh
}

Python-install()
{
    PS3="Python版本安装向导---->请选择安装的版本:" # 设置提示符字串.  
    echo
    select Version in 'Add deb source' 'Python2.7x(OS Default,recommend install)' 'Python3.5(OS Default,recommend install)' 'Python3.6' 'Python3.7' 'Python3.8' 'Pass'
    do
    	case $Version in
    	'Add deb source') sudo add-apt-repository ppa:deadsnakes/ppa;sudo apt-get update ;; 
    	'Python2.7x(OS Default,recommend install)') sudo apt-get install -y python python-pip;python -m pip install --upgrade pip ;;
    	'Python3.5(OS Default,recommend install)') sudo apt-get install -y python3 python3-pip;python3 -m pip install --upgrade pip ;;
        'Python3.6') sudo apt-get install -y python3.6 python3-pip;python3 -m pip install --upgrade pip ;;
    	'Python3.7') sudo apt-get install -y python3.7 python3-pip;python3 -m pip install --upgrade pip ;;
        'Python3.8') sudo apt-get install -y python3.8* python3-pip libpython3.8*;python3 -m pip install --upgrade pip ;;
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
}

version-fix()
{
	sudo apt-get remove -y --purge python3-apt
	sudo apt-get install -f -y python3-apt
	case $1 in
		'python3.6') sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-36m-x86_64-linux-gnu.so;;
		'python3.7') sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-37m-x86_64-linux-gnu.so;;
		'python3.8') sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-38m-x86_64-linux-gnu.so
		sudo apt remove -y python3-pip;sudo python3.8 -m easy_install pip;python3.8 -m pip install --upgrade pip setuptools wheel;
		apt-get install -y python-apt;;
					
	esac
	pip -V
	python3 -m pip install --upgrade pip
    pip -V
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
		select version in 'Python3.5(OS Default)' 'Python3.6' 'Python3.7' 'Python3.8' 'Exit'
		do
			case $version in
			'Python3.5(OS Default)') modify /usr/bin/python3.5 ;;
			'Python3.6') modify /usr/bin/python3.6;version-fix python3.6 ;;
			'Python3.7') modify /usr/bin/python3.7;version-fix python3.7 ;;
			'Python3.8') modify /usr/bin/python3.8;version-fix python3.8;;
			'Exit') echo "退出";break 2 ;;
			esac
		done;;
    	No) echo "退出";break ;;
    	esac
    done
}


Docker-Setup()
{
    get-version()
    {
    Py=$( python3 -V | cut -c 8- )
    if [ "$Py" = '3.8.6' ]
    then
        echo "Python 版本为 $Py"
        cp ./OS-Version/Ubuntu1604/add-apt-repository /usr/bin/;
        rm /usr/bin/.add-apt-repository.swp;
        cat /usr/bin/add-apt-repository;
    else
        echo -e "\033[32mYour Python3's version needn't to fix.\033[1;0m"
    fi
    }
    echo "正在安装Docker..." # test
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    get-version
    curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/ $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo docker -v
}