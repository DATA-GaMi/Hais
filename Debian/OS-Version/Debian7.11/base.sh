#!/usr/bin/env bash
source OS-Version/Debian7.11/Function.sh
pwd
#Debian7.11的Python2的默认版本为2.7.3,Python3的版本默认为3.2.3
release_num=$(lsb_release -rs)
release_type=$(lsb_release -is)
echo "Get the System Version..."
echo "The system version is $release_type-$release_num"
echo "检查更新...正在更新安装基本组件"
base-env
easy_install pip
zlibg
PS3="Python3版本安装向导---->请选择安装的版本:" # 设置提示符字串.  
echo
select V in 'Python2.7' 'Python3.5' 'Python3.6' 'Pass'
do
	case $V in
	'Python2.7') download-install python2.7 ;;
	'Python3.5') download-install python3.5 ;; 
	'Python3.6') download-install python3.6 ;;
    'Pass') echo "跳过";break ;;
	esac
done

PS3="是否设置优先级?y/n:"
echo
select Choice in Yes No
do
	case $Choice in
	Yes) PS3="设置哪个Python3版本为优先使用?选择版本:"
		 echo ;
		select version in 'Python2.7' 'Python3.5' 'Python3.6' 'Python3.7' 'Python3.8' 'Exit'
		do
			case $version in
			'Python2.7') update-alternatives --install /usr/local/bin/python python /usr/local/bin/python2.7 ;;
			'Python3.5') modify /usr/local/bin/python3.5 ;; 
			'Python3.6') modify /usr/local/bin/python3.6 ;;
			'Exit') echo "退出";break 2 ;;
			esac
		done;;
	No) echo "退出";break ;;
	esac
done