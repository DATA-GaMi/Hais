#!/usr/bin/env bash
source OS-Version/Debian9-newly/Function.sh
release_num=$(lsb_release -rs)

if [[ "$release_num" == 9.0 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1;base-env-2
    Python-install;zlibg
    
    Version-choice;up-alternatives
    docker-dep;docker-install
elif [[ "$release_num" == 9.1 ]];
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
elif [[ "$release_num" == 9.2 ]];
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
elif [[ "$release_num" == 9.3 ]];
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
elif [[ "$release_num" == 9.4 ]];
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
elif [[ "$release_num" == 9.5 ]];
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
elif [[ "$release_num" == 9.6 ]];
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
elif [[ "$release_num" == 9.7 ]];
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
elif [[ "$release_num" == 9.8 ]];
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
elif [[ "$release_num" == 9.9 ]];
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
elif [[ "$release_num" == 9.10 ]];
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
elif [[ "$release_num" == 9.11 ]];
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
elif [[ "$release_num" == 9.12 ]];
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
else
    echo "啥也不是"
fi