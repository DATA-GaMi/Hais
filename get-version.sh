#!/usr/bin/env bash

:<<EOF
 ___  ___  ________  ___  ________
|\  \|\  \|\   __  \|\  \|\   ____\
\ \  \\\  \ \  \|\  \ \  \ \  \___|_
 \ \   __  \ \   __  \ \  \ \_____  \
  \ \  \ \  \ \  \ \  \ \  \|____|\  \
   \ \__\ \__\ \__\ \__\ \__\____\_\  \
    \|__|\|__|\|__|\|__|\|__|\_________\
                            \|_________|
EOF

#Half Auto Install Script

release_type=$(lsb_release -i --short)
release_type1=$(cat /etc/redhat-release | cut -c 1-6)
if [ "$release_type" = Ubuntu ]
then
    chmod +x Ubuntu/*
    cd Ubuntu/ || return
    bash Main.sh 2>&1 | tee Ubuntu-logfile
elif [ "$release_type1" = CentOS ];
then
    chmod +x CentOS/*
    echo -e "\033[33m$release_type1\033[0m"
    cd CentOS/ || return
    ls
    bash Main.sh 2>&1 | tee CentOS-logfile
elif [ "$release_type" = Debian ];
then
    chmod +x Denian/*
    cd Debian/ || return
    ls
    bash Main.sh 2>&1 | tee Debian-logfile
else
    echo "不知道的版本"
fi