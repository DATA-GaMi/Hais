#!/usr/bin/env bash

source OS-Version/CentOS8-8.1/Function.sh
release_num=$(echo $(cat /etc/redhat-release | cut -c 21- | cut -c -4))

if [ "$release_num" == 8.0 ]
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 8.1 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
fi