#!/usr/bin/env bash
release_num=$(lsb_release -rs)


replace()
{
        if [ "$release_num" == 14.04 ]
        then
        str1="ExecStart=/usr/bin/dockerd -H fd://"
        str2="ExecStart=/usr/bin/dockerd -H fd:// --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H unix://var/run/docker.sock -H tcp://0.0.0.0:2376"
        sed -i "s!${str1}!${str2}!" /lib/systemd/system/docker.service
        cat /lib/systemd/system/docker.service
        systemctl daemon-reload
        systemctl restart docker
        else
        str1="ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock"
        str2="ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H unix://var/run/docker.sock -H tcp://0.0.0.0:2376"
        sed -i "s!${str1}!${str2}!" /lib/systemd/system/docker.service
        cat /lib/systemd/system/docker.service
        systemctl daemon-reload
        systemctl restart docker
        fi

        echo "设置替换完成"
}



echo "查询Docker.Service设置."
grep -n '--tlsverify --tlscacert=/etc/docker/ca.pem' /lib/systemd/system/docker.service
if [ $? -eq 0 ]
then
	echo "设置已替换完成，不用再次替换."
else
	echo "开始替换设置..."
        replace
fi
ps -fe | grep /usr/bin/dockerd | grep -v grep
if [ $? -eq 0 ]
then
	echo "Docker服务重启成功."
else
	echo "Docker服务重启失败."
	exit 1
fi



