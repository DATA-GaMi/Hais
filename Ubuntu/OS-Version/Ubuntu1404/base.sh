#!/usr/bin/env bash
release_num=$(lsb_release -r --short)
release_type=$(lsb_release -i --short)
echo "Get the System Version..."
echo "The system version is $release_type-$release_num"
echo "检查更新...正在更新安装基本组件"
sudo apt-get update
if [ "$release_num" == 14.04 ];then
	sudo apt-get -y install --reinstall systemd
else
	echo "Your OS version do not need reinstall systemed!"
fi
sudo apt-get install -y vim curl git wget ssh software-properties-common yum
#/etc/init.d/ssh start->修改/etc/rc.local，在exit0之前
systemctl enable ssh
sed '/exit 0/i\/etc/init.d/ssh start' /etc/rc.local
PS3="Python版本安装向导---->请选择安装的版本:" # 设置提示符字串.  
echo
select Version in 'Add deb source' 'Python2.7x+Python3.4.x' 'Python3.5' 'Python3.6' 'Python3.7' 'Pass'
do
	case $Version in
	'Add deb source') sudo add-apt-repository ppa:deadsnakes/ppa;sudo apt-get update ;;
	'Python2.7x+Python3.4.x') sudo apt-get install -y python python-pip python3 python3-pip ;;
	'Python3.5') sudo apt-get install -y python3.5 libpython3.5 ;;
    'Python3.6') sudo apt-get install -y python3.6 libpython3.6 ;;
	'Python3.7') sudo apt-get install -y python3.7 libpython3.7 ;;
    'Pass') break ;;
	esac
done
function modify
{
        for i in /usr/bin/python3.?
        do
                update-alternatives --install /usr/bin/python3 python3 "$i" 1
        done
        update-alternatives --install /usr/bin/python3 python3 "$1" 2
        python3 -m pip install --upgrade pip
        pip -V
}
PS3="是否设置优先级?y/n:"
echo
select Choice in Yes No
do
	case $Choice in
	Yes) PS3="设置哪个Python3版本为优先使用?选择版本:"
		 echo ;
		select version in 'Python3.4(OS Default)' 'Python3.5' 'Python3.6' 'Python3.7' 'Exit'
		do
			case $version in
			'Python3.4(OS Default)') modify /usr/bin/python3.4 ;;
			'Python3.5') modify /usr/bin/python3.5;sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-34m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-35m-x86_64-linux-gnu.so;;
			'Python3.6') modify /usr/bin/python3.6;sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-34m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-36m-x86_64-linux-gnu.so;;
			'Python3.7') modify /usr/bin/python3.7;sudo cp /usr/lib/python3/dist-packages/apt_pkg.cpython-34m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.cpython-37m-x86_64-linux-gnu.so;;
			'Exit') echo "退出";break 2 ;;
			esac
		done;;
	No) echo "退出";break ;;
	esac
done