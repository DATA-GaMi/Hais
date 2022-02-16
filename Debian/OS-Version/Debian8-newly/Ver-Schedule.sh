#!/usr/bin/env bash
source OS-Version/Debian8-newly/Function.sh
release_num=$(lsb_release -rs)

if [[ "$release_num" == 8.0 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1;base-env-2
    Python-install;zlibg
    
    Version-choice;up-alternatives
    docker-dep;docker-install
elif [[ "$release_num" == 8.1 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install
elif [[ "$release_num" == 8.2 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install
elif [[ "$release_num" == 8.3 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install
elif [[ "$release_num" == 8.4 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install
elif [[ "$release_num" == 8.5 ]];
then
    echo -n "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install    
elif [[ "$release_num" == 8.6 ]];
then
    echo -n "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install 
elif [[ "$release_num" == 8.7 ]];
then
    echo -n "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install 
elif [[ "$release_num" == 8.8 ]];
then
    echo -n "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install 
elif [[ "$release_num" == 8.9 ]];
then
    echo -n "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install 
elif [[ "$release_num" == 8.10 ]];
then
    echo -n "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1
    base-env-2
    Python-install
    zlibg
    
    Version-choice
    up-alternatives
    docker-dep
    docker-install 
fi