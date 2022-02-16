#!/usr/bin/env bash

base-env1()
{
    echo -e "\033[33m安装基本环境... \033[0m"
    sudo yum install -y net-tools openssh openssl openssl-devel vim wget curl git ca-certificates make gcc g++

}

zlibg()
{
    cd /usr/share/ || return
    wget https://jaist.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz
    tar -zxvf zlib-1.2.11.tar.gz && rm zlib-1.2.11.tar.gz
    cd zlib-1.2.11/ || return
    ./configure > /dev/null;make && make install 
    cd "$BASE_PATH" || return
}

sslinstall()
{
    echo -e "\033[33m安装openssl-1.1.1g... \033[0m"
    cd "$INSTALL_PATH" || return
    wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz
    tar -zxvf openssl-1.1.1g.tar.gz && cd openssl-1.1.1g && ./config --prefix=/usr/local/openssl no-zlib;
    make && make install
    mv /usr/bin/openssl /usr/bin/openssl.bak && mv /usr/include/openssl/ /usr/include/openssl.bak
    ln -s /usr/local/openssl/include/openssl /usr/include/openssl
    ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/local/lib64/libssl.so
    ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
    echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
    ldconfig -v > /dev/null
    openssl version
    export LDFLAGS=" -L/usr/local/openssl/lib"
    export CPPFLAGS=" -I/usr/local/openssl/include"
    export PKG_CONFIG_PATH="/usr/local/openssl/lib/pkgconfig"
    cd "$BASE_PATH" || return
}

Py-Download()
{
    if [ "$1" = "python3.5" ]
    then
        echo -e "Downloading Python3.5.10..."
        cd "$INSTALL_PATH" || return
        wget --no-check-certificate https://www.python.org/ftp/python/3.5.10/Python-3.5.10.tgz
        tar -zxvf Python-3.5.10.tgz;rm Python-3.5.10.tgz;mv  Python-3.5.10/ python3.5/
        cd python3.5/ && ./configure --with-ssl && make && make install
        python3 -m ensurepip && python3 -m pip install --upgrade pip
        cd "$BASE_PATH" || return
    elif [ "$1" = "python3.6" ];
    then
        echo -e "Downloading Python3.6.12..."
        cd "$INSTALL_PATH" || return
        wget --no-check-certificate https://www.python.org/ftp/python/3.6.12/Python-3.6.12.tgz
        tar -zxvf Python-3.6.12.tgz;rm Python-3.6.12.tgz;mv Python-3.6.12 python3.6
        cd python3.6/ && ./configure --with-ssl && make && make install
        python3 -m pip install --upgrade pip
        cd "$BASE_PATH" || return
    elif [ "$1" = "python3.7" ];
    then
        echo -e "Downloading Python3.7.9..."
        cd "$INSTALL_PATH" || return
        #sslinstall
        wget --no-check-certificate https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
        tar -zxvf Python-3.7.9.tgz;rm Python-3.7.9.tgz;mv Python-3.7.9 python3.7
        cd python3.7 && ./configure --with-openssl=/usr/local/openssl && make && make install
        python3 -m pip install --upgrade pip
        cd "$BASE_PATH" || return
    elif [ "$1" = "python3.8" ];
    then
        echo -e "Downloading Python3.8.6..."
        cd "$INSTALL_PATH" || return
        #sslinstall
        wget --no-check-certificate https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
        tar -zxvf Python-3.8.6.tgz;rm Python-3.8.6.tgz;mv Python-3.8.6 python3.8
        cd python3.8 && ./configure --with-openssl=/usr/local/openssl && make && make install
        python3 -m pip install --upgrade pip
        cd "$BASE_PATH" || return
    elif [ "$1" = "python2.7" ];
    then
        echo -e "Downloading Python2.7.18..."
        cd "$INSTALL_PATH" || return
        wget --no-check-certificate https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
        tar -zxvf Python-2.7.18.tgz;rm Python-2.7.18.tgz
        cd Python-2.7.18 && ./configure --with-ssl && make && make install
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python get-pip.py
        cd "$BASE_PATH" || return
    fi
}

Py-Mod()
{
        for i in /usr/local/bin/python3.?
        do
                update-alternatives --install /usr/local/bin/python3 python3 "$i" 1
        done
        update-alternatives --install /usr/local/bin/python3 python3 "$1" 2
        python3 -m pip install --upgrade pip
        pip3 -V
}

Py-Install()
{
    PS3="Python3版本安装向导---->请选择安装的版本:" # 设置提示符字串.  
    echo
    select V in 'Python2.7' 'Python3.5' 'Python3.6' 'Python3.7' 'Python3.8' 'Pass'
    do
	    case $V in
	    'Python2.7') Py-Download python2.7 ;;
	    'Python3.5') Py-Download python3.5 ;;
	    'Python3.6') Py-Download python3.6 ;;
        'Python3.7') Py-Download python3.7 ;;
        'Python3.8') Py-Download python3.8 ;;
        'Pass') echo "跳过";break ;;
	    esac
    done
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
		    select version in 'Python2.7' 'Python3.5' 'Python3.6' 'Python3.7' 'Python3.8' 'Exit'
		    do
			    case $version in
			    'Python2.7') update-alternatives --install /usr/local/bin/python python /usr/local/bin/python2.7 ;;
			    'Python3.5') Py-Mod /usr/local/bin/python3.5 ;; 
			    'Python3.6') Py-Mod /usr/local/bin/python3.6 ;;
                'Python3.7') Py-Mod /usr/local/bin/python3.7 ;;
                'Python3.8') Py-Mod /usr/local/bin/python3.8 ;;
			    'Exit') echo "退出";break 2 ;;
			    esac
		    done;;
	    No) echo "退出";break ;;
	    esac
    done
}

Docker-Dep()
{
    echo -e "\033[33m安装Docker依赖... \033[0m"
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/docker-ce.repo
}

Docker-Set()
{
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    systemctl start docker
    systemctl enable docker
}