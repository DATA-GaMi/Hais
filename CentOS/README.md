说明：此脚本虽然有CentOS6的文件夹，但是脚本不支持测试CentOS6

经过一些测试发现CentOS6安装Docker需要更新内核并重启


ContainerScript文件夹----存放的是开启各个基础镜像的脚本

Base-Image文件夹----存放如:Postgresql、Portainer、Mongodb等基础镜像

Tools-Image文件夹----存放如:afl、angora、aflfast等工具镜像


Extra文件夹---存放 Docker 的 CA 替换脚本