#!/usr/bin/env bash

source OS-Version/CentOS6-6.10/Function.sh
release_num=$(echo $(cat /etc/redhat-release | cut -c 21- | cut -c -4))

if [ "$release_num" == 6.6 ]
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 6.7 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 6.8 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 6.9 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 6.10 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    Py-Pro
    Docker-Dep
    Docker-Set
fi