#!/usr/bin/env bash
source OS-Version/Debian10-newly/Function.sh
release_num=$(lsb_release -rs)

if [[ "$release_num" == 10 ]];
then
    echo "Get the System Version..."
    echo -e "\033[36msystem version is $release_num\033[0m"
    base-env-1;base-env-2
    Python-install;zlibg
    
    Version-choice;up-alternatives
    docker-dep;docker-install
else
    echo "没这个版本"
fi