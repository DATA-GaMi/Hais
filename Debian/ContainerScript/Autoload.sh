#!/usr/bin/env bash
for Image in  $*
do
    echo "Loading ${Image%.*} Image..." # 白字
    ImageName=$(docker load -i $Image | cut -c 15-)
    ImgId=$(docker images --no-trunc -q $ImageName)
    InsId=$(docker inspect -f '{{.Id}}' $ImageName)
    echo -e "\033[36mChecking sha256 id ... \033[0m" # 天蓝字
    if [ ${ImgId} = ${InsId} ]
    then
        echo -e "\033[5;32mImage ${ImageName} load finished! \033[1;0m" # 闪烁绿字
        rm $Image
    else
        echo -e "\033[5;31mERROR:Image ${ImageName} load failed,because sha256 not match! \033[1;0m" # 闪烁红字
        echo ${Image} may have some mistakes. >> error.log
    fi
    sleep 1
done
echo -e "\033[33mNote: All docker images load finished! \033[1;0m"