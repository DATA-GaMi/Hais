#!/usr/bin/env bash

source OS-Version/CentOS7-7.7/Function.sh
release_num=$(echo $(cat /etc/redhat-release | cut -c 21- | cut -c -4))

if [ "$release_num" == 7.0 ]
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.1 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.2 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.3 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.4 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.5 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.6 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
elif [ "$release_num" == 7.7 ];
then
    base-env1
    zlibg
    sslinstall
    Py-Install
    
    
    Py-Pro
    Docker-Dep
    Docker-Set
fi