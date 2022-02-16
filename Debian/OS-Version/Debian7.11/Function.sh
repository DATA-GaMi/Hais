#!/usr/bin/env bash

#  libexpat1-dev libpython3.2 libssl-dev libssl-doc python3-dev python3-minimal python3-pkg-resources
#python3-setuptools python3.2 python3.2-dev python3.2-minimal zlib1g-dev
function base-env
{
    sudo apt-get update
sudo apt-get install -y vim curl git ssh wget software-properties-common apt-transport-https ca-certificates gnupg-agent gcc g++ --fix-missing
    echo -e "\033[33m安装Python基本环境... \033[0m"
    apt-get install debian-keyring
    apt-get install libssl1.0.0=1.0.1e-2+deb7u20 libncurses5-dev libncursesw5-dev libreadline6-dev libssl-doc  ncurses-doc --fix-missing
    apt-get install libdb-dev libgdbm-dev libsqlite3-dev libssl-dev --fix-missing
    apt-get install libbz2-dev libexpat1=2.1.0-1+deb7u2 liblzma-dev zlib1g-dev --fix-missing
    apt-get install openssl make
    sudo apt-get install -y python python-all-dev python-pip --fix-missing
    sudo apt-get install -y python3 python3-all-dev python3-pip --fix-missing
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
        wget --no-check-certificate https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
        tar -zxvf Python-3.7.9.tgz;rm Python-3.7.9.tgz;mv Python-3.7.9 python3.7
        cd python3.7 && ./configure --with-ssl && make && make install
        python3 -m pip install --upgrade pip
        cd "$BASE_PATH" || return
    elif [ "$1" = "python3.8" ];
    then
        echo -e "Downloading Python3.8.6..."
        cd "$INSTALL_PATH" || return
        wget --no-check-certificate https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
        tar -zxvf Python-3.8.6.tgz;rm Python-3.8.6.tgz;mv Python-3.8.6 python3.8
        cd python3.8 && ./configure --with-ssl && make && make install
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
        python3 -m pip install --upgrade pip3
        pip3 -V
}

update-alternatives --install /usr/local/bin/python3 python3 /usr/local/bin/python3.6 2
