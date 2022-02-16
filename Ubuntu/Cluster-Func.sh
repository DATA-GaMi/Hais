#!/usr/bin/env bash

#拉取mongo4.0.0的镜像，如果存在则不拉取

Docker-pull()
{   
    ImageName="mongo:4.0.0"
    docker inspect -f '{{.Id}}' $ImageName
    if [ $? -eq 0 ]
    then
        echo -e "\033[32mDocker images already exists!\033[1;0m"
    else
        docker pull mongo:4.0.0
    fi
}

Net-Bridge()
{
    docker network create --subnet=10.1.1.0/24 mongodb0
    docker network inspect mongodb0
    sleep 5
}

Mk-Dir()
{
    for i in configsvr shard1 shard2 shard3 mongos
    do
        mkdir -p /home/dmc/"$i"
        touch /app/data/Cluster/"$i"/mongod.conf
    done
    mv /app/data/Cluster/mongos/mongod.conf /app/data/Cluster/mongos/mongos.conf
    ls -al /app/data/Cluster/*
    sleep 5
}

Wr-Conf()
{
    cat > /app/data/Cluster/configsvr/mongod.conf << EOF
        storage:
          dbPath: /data/db
          journal:
            enabled: true
        systemLog:
          destination: file
          logAppend: true
          path: /var/log/mongodb/mongod.log
        net:
          bindIp: 127.0.0.1
        processManagement:
          timeZoneInfo: /usr/share/zoneinfo
        replication:
          replSetName: cfg
        sharding:
          clusterRole: configsvr
EOF

    for shard in shard1 shard2 shard3
    do
        cat > /app/data/Cluster/"$shard"/mongod.conf << EOF
            storage:
              dbPath: /data/db
              journal:
                enabled: true
            systemLog:
              destination: file
              logAppend: true
              path: /var/log/mongodb/mongod.log
            net:
              bindIp: 127.0.0.1
            processManagement:
              timeZoneInfo: /usr/share/zoneinfo
            replication:
              replSetName: $shard
            sharding:
              clusterRole: shardsvr
EOF
    done
    cat > /app/data/Cluster/mongos/mongos.conf << EOF
        systemLog:
          destination: file
          logAppend: true
          path: /var/log/mongodb/mongos.log
        net:
          port: 27020
          bindIp: 0.0.0.0
        processManagement:
          fork: true
          timeZoneInfo: /usr/share/zoneinfo
        sharding:
          configDB: cfg/10.1.1.2:27019,10.1.1.3:27019,10.1.1.4:27019
EOF
}

Docker-run-configsvr()
{
    for (( a=1,b=2 ; a <=3; a++,b++ ))
    do
        docker run -d --name=cfg_"$a" --network=mongodb0 --ip=10.1.1."$b" -v /app/data/Cluster/configsvr:/etc/mongodb mongo:4.0.0 -f /etc/mongodb/mongod.conf
        Status=$(docker inspect -f '{{.State.Status}}' "cfg_$a")
        if [ "$Status" = running ]
        then
            echo -e "\033[32mCreate cfg_$a container successful! \033[0m" #Color is green
        else
            echo -e "\033[31mError:Create cfg_$a container failed! \033[0m" #Color is red
        fi
    done    
}

#启动第一个分片
Docker-run-Shard1()
{
    for (( a=1,b=5 ; a <=3 ; a++,b++))
    do
        docker run -d --name=shard1_"$a" --network==mongodb0 --ip==10.1.1."$b" -v /app/data/Cluster/shard1:/etc/mongodb mongo:latest -f /etc/mongodb/mongodb.conf
        if [ "$Status" = running ]
        then
            echo -e "\033[32mCreate shard1_$a container successful! \033[0m" #Color is green
        else
            echo -e "\033[31mError:Create shard1_$a container failed! \033[0m" #Color is red
        fi
    done
}
#启动第二个分片
Docker-run-Shard2()
{
    for (( a=1,b=8 ; a <=3 ; a++,b++))
    do
        docker run -d --name=shard2_"$a" --network==mongodb0 --ip==10.1.1."$b" -v /app/data/Cluster/shard2:/etc/mongodb mongo:latest -f /etc/mongodb/mongodb.conf
        if [ "$Status" = running ]
        then
            echo -e "\033[32mCreate shard2_$a container successful! \033[0m" #Color is green
        else
            echo -e "\033[31mError:Create shard2_$a container failed! \033[0m" #Color is red
        fi
    done
}

#启动第三个分片
Docker-run-Shard3()
{
    for (( a=1,b=11 ; a <=3 ; a++,b++))
    do
        docker run -d --name=shard3_"$a" --network==mongodb0 --ip==10.1.1."$b" -v /app/data/Cluster/shard3:/etc/mongodb mongo:latest -f /etc/mongodb/mongodb.conf
        if [ "$Status" = running ]
        then
            echo -e "\033[32mCreate shard3_$a container successful! \033[0m" #Color is green
        else
            echo -e "\033[31mError:Create shard3_$a container failed! \033[0m" #Color is red
        fi
    done
}
#启动3个mongos服务器
Docker-run-Mongos()
{
	for (( a=1,b=14 ; a <=3 ; a++,b++))
    do
        docker run -d --name=mongos_"$a" --network==mongodb0 --ip==10.1.1."$b" -v /app/data/Cluster/mongos:/etc/mongodb
        if [ "$Status" = running ]
        then
            echo -e "\033[32mCreate mongos_$a container successful! \033[0m" #Color is green
        else
            echo -e "\033[31mError:Create mongos_$a container failed! \033[0m" #Color is red
        fi
    done
}