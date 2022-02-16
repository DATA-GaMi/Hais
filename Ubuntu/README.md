Ubuntu脚本支持性最好
无不良反应

ContainerScript文件夹----存放的是开启各个基础镜像的脚本

Base-Image文件夹----存放如:Postgresql、Portainer、Mongodb等基础镜像

Tools-Image文件夹----存放如:afl、angora、aflfast等工具镜像

Extra文件夹---存放 Docker 的 CA 替换脚本

1.将master.conf文件放在运行automongo.py的目录下
2.将dockermaster.py移动到宿主机的/data/script/ 路径下
3.在宿主机中运行automongo.py