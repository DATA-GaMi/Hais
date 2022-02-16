#!/usr/bin/env bash

#  libexpat1-dev libpython3.2 libssl-dev libssl-doc python3-dev python3-minimal python3-pkg-resources
#python3-setuptools python3.2 python3.2-dev python3.2-minimal zlib1g-dev
function base-env-1
{
    echo -e "\033[33m安装基本环境... \033[0m"
    apt-get update
    apt-get -y install sudo ssh vim curl git wget software-properties-common net-tools
    systemctl enable ssh
    apt-get -y install apt-transport-https ca-certificates gnupg-agent  make gcc g++
    
}

function base-env-2
{
    echo -e "\033[33m安装Python基本环境... \033[0m"
    apt-get install debian-keyring
    apt-get install libssl1.0.0=1.0.1e-2+deb7u20 libncurses5-dev libncursesw5-dev libreadline6-dev libssl-doc  ncurses-doc --fix-missing
    apt-get install libdb-dev libgdbm-dev libsqlite3-dev libssl-dev --fix-missing
    apt-get install libbz2-dev libexpat1=2.1.0-1+deb7u2 liblzma-dev zlib1g-dev --fix-missing
    apt-get install openssl

}

function Python-install
{
    #安装Python
    apt-get install -y python python-all-dev python-pip --fix-missing
    #安装Python3
    apt-get install -y python3 python3-all-dev python3-pip --fix-missing
}

function zlibg
{
    cd /usr/share/ || return
    wget https://jaist.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz
    tar -zxvf zlib-1.2.11.tar.gz && rm zlib-1.2.11.tar.gz
    cd zlib-1.2.11/ || return
    ./configure > /dev/null;make && make install 
    cd "$BASE_PATH" || return
}

function sslinstall
{
    wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz
    tar -zxvf openssl-1.1.1g.tar.gz && cd openssl-1.1.1g && ./config --prefix=/usr/local/openssl no-zlib;
    make && make install
    mv /usr/bin/openssl /usr/bin/openssl.bak && mv /usr/include/openssl/ /usr/include/openssl.bak
    ln -s /usr/local/openssl/include/openssl /usr/include/openssl
    ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/local/lib64/libssl.so
    ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
    echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
    # echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/openssl/lib" >> /etc/profile
    ldconfig -v > /dev/null
    # source /etc/profile
    openssl version
    export LDFLAGS=" -L/usr/local/openssl/lib"
    export CPPFLAGS=" -I/usr/local/openssl/include"
    export PKG_CONFIG_PATH="/usr/local/openssl/lib/pkgconfig"
    cd ..
}

function download-install
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
        sslinstall
        wget --no-check-certificate https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
        tar -zxvf Python-3.7.9.tgz;rm Python-3.7.9.tgz;mv Python-3.7.9 python3.7
        cd python3.7 && ./configure && make && make install
        python3 -m pip install --upgrade pip
        cd "$BASE_PATH" || return
    elif [ "$1" = "python3.8" ];
    then
        echo -e "Downloading Python3.8.6..."
        cd "$INSTALL_PATH" || return
        sslinstall
        wget --no-check-certificate https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
        tar -zxvf Python-3.8.6.tgz;rm Python-3.8.6.tgz;mv Python-3.8.6 python3.8
        cd python3.8 && ./configure && make && make install
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

function modify
{
        for i in /usr/local/bin/python3.?
        do
                update-alternatives --install /usr/local/bin/python3 python3 "$i" 1
        done
        update-alternatives --install /usr/local/bin/python3 python3 "$1" 2
        python3 -m pip install --upgrade pip
        pip3 -V
}

function Version-choice
{
    PS3="Python3版本安装向导---->请选择安装的版本:" # 设置提示符字串.  
    echo
    select V in 'Python2.7' 'Python3.5' 'Python3.6' 'Python3.7' 'Python3.8' 'Pass'
    do
	    case $V in
	    'Python2.7') download-install python2.7 ;;
	    'Python3.5') download-install python3.5 ;; 
	    'Python3.6') download-install python3.6 ;;
        'Python3.7') download-install python3.7 ;;
        'Python3.8') download-install python3.8 ;;
        'Pass') echo "跳过";break ;;
	    esac
    done
}


function up-alternatives
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
			    'Python3.5') modify /usr/local/bin/python3.5 ;; 
			    'Python3.6') modify /usr/local/bin/python3.6 ;;
                'Python3.7') modify /usr/local/bin/python3.7 ;;
                'Python3.8') modify /usr/local/bin/python3.8 ;;
			    'Exit') echo "退出";break 2 ;;
			    esac
		    done;;
	    No) echo "退出";break ;;
	    esac
    done
}

function docker-dep
{
    apt-get update
    apt-get dist-upgrade -y
    apt-get install apt-transport-https python-software-properties -y
}

function docker-install
{
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
}