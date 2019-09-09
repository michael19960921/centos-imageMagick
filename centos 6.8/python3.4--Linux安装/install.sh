#!/bin/sh
#运行操作系统要求：CentOS Linux release 7.2.1511 (Core) 

echo "start install python 3.6.4"
root_path="$PWD"
#<<COMMENT
chmod 777 -R ./

#安装Python-3.6.4
rm -rf Python-3.6.4
tar -xvf Python-3.6.4.tgz
cd Python-3.6.4


if [ -d /usr/local/python3 ]
then
	rm -rf  /usr/local/python3
else
	echo "/usr/local/python3 is not exist."
fi

#生成静态库*.a
#./configure --prefix=/usr/local/python3 && make && make install 
#生成动态库*.so
./configure --prefix=/usr/local/python3 --enable-shared CFLAGS=-fPIC && make && make install
cd ..

if [ -f /usr/bin/python ]
then
	mv -f /usr/bin/python /usr/bin/python_bak
else
	echo "/usr/bin/python is not exist."
fi

if [ -f /usr/bin/pip ]
then
	mv -f /usr/bin/pip /usr/bin/pip_bak
fi

if [ -f /usr/bin/pip3 ]
then
	mv -f /usr/bin/pip3 /usr/bin/pip3_bak
fi

rm -f /usr/bin/python
rm -f /usr/bin/pip
rm -f /usr/bin/pip3

ln -s 	/usr/local/python3/bin/python3 		/usr/bin/python
ln -s 	/usr/local/python3/bin/pip3.6 		/usr/bin/pip
ln -s 	/usr/local/python3/bin/pip3.6 		/usr/bin/pip3

ln -s /usr/local/python3/lib/libpython3.6m.so.1.0       /usr/lib/libpython3.6m.so.1.0
ln -s /usr/local/python3/lib/libpython3.6m.so.1.0       /usr/lib/libpython3.6m.so
ldconfig

echo -e "\n"
python -V

echo "install Python-3.6.4 is finish."


#安装 python画图用的扩展库 matplotlib-2.2.2.tar.gz
#在线安装
#yum install python-matplotlib
#pip install matplotlib

######################## 安装matplotlib依赖库 ########################################################################

<<COMMENT__Dependencies_matplotlib

#先安装matplotlib-2.2.2库依赖的库
Dependencies
Matplotlib requires a large number of dependencies:
13个依赖包

Python (>= 2.7 or >= 3.4)
NumPy (>= 1.7.1)
setuptools
dateutil (>= 2.1)
pyparsing
libpng (>= 1.2)
pytz
FreeType (>= 2.3)
cycler (>= 0.10.0)
six
backports.functools_lru_cache (for Python 2.7 only)
subprocess32 (for Python 2.7 only, on Linux and macOS only)
kiwisolver (>= 1.0.0)

COMMENT__Dependencies_matplotlib


#COMMENT

#安装 numpy-1.11.2.tar.gz
#1.下载源码包：wget http://jaist.dl.sourceforge.net/project/numpy/NumPy/1.9.0/numpy-1.9.0.zip
tar -xzvf numpy-1.11.2.tar.gz
cd numpy-1.11.2
python setup.py install
#numpy测试是否安装成功：python && from numpy import *  && eye(4) 
cd ../

#安装 kiwisolver-1.0.1.tar.gz
#https://pypi.python.org/pypi/kiwisolver/1.0.1
tar -xzvf kiwisolver-1.0.1.tar.gz
cd kiwisolver-1.0.1
python setup.py install
cd ../

#安装 six-1.11.0.tar.gz
#https://pypi.python.org/pypi/six/1.11.0
tar -xzvf six-1.11.0.tar.gz
cd six-1.11.0
python setup.py install
cd ../

#安装 pytz-2018.4.tar.gz
#https://pypi.python.org/pypi/pytz/2018.4
tar -xzvf pytz-2018.4.tar.gz
cd pytz-2018.4
python setup.py install
cd ../

#安装 setuptools_scm-2.0.0.tar.gz
#https://pypi.python.org/pypi/setuptools-scm-about/1.0
tar -xzvf setuptools_scm-2.0.0.tar.gz
cd setuptools_scm-2.0.0
python setup.py install
cd ../

#安装 python-dateutil-2.7.2.tar.gz
#https://pypi.python.org/pypi/python-dateutil/2.7.2
tar -xzvf python-dateutil-2.7.2.tar.gz
cd python-dateutil-2.7.2
python setup.py install
cd ../

#安装 pyparsing-2.2.0.tar.gz
#https://pypi.python.org/pypi/pyparsing/2.2.0
tar -xzvf pyparsing-2.2.0.tar.gz
cd pyparsing-2.2.0
python setup.py install
cd ../

#安装 cycler-0.10.0.tar.gz
#https://pypi.python.org/pypi/Cycler/0.10.0
tar -xzvf cycler-0.10.0.tar.gz
cd cycler-0.10.0
python setup.py install
cd ../

######################## end 安装matplotlib依赖库 ########################################################################

#离线安装 matplotlib-2.2.2.tar.gz
rm -rf matplotlib-2.2.2
tar -xzvf matplotlib-2.2.2.tar.gz
cd matplotlib-2.2.2
python setup.py build
python setup.py install
cd ../

#测试是滞正确安装 matplotlib-2.2.2.tar.gz
#python -c "import matplotlib; print (matplotlib.__version__)"

#1>  fgf查看python,numpy,scipy,matplotlib的版本及安装位置 
#        1、查看python版本
#        　　python -V
#        　　python --version
#        2、查看python安装位置
#            python -c "import sys; print (sys.executable)"
#        　　python -c "import os; print (os.sys.executable)"
#        3、查看Numpy版本
#            python -c "import numpy; print (numpy.version.version)"
#            python -c "import numpy; print (numpy.__version__)"
#        4、查看Numpy安装路径
#            python -c "import numpy; print (numpy.__file__)"
#        5、查看SciPy版本
#            python -c "import scipy; print (scipy.version.version)"
#        6、查看SciPy安装路径
#            python -c "import scipy; print (scipy.__file__)"
#        7、查看Matplotlib版本
#            python -c "import matplotlib; print (matplotlib.__version__)"
#        8、查看Matplotlib安装路径
#            python -c "import matplotlib; print (matplotlib.matplotlib_fname())"

#[root@linuxprobe python]# python -c "import matplotlib; print (matplotlib.matplotlib_fname())"
#/usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/matplotlibrc
#/usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/
#/usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data

#彻底解决matplotlib中文乱码问题             ->  第三钟解决办法
#安装字体
cp -rf simhei.ttf  /usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/fonts/ttf/simhei.ttf
#然后删除~/.cache/matplotlib的缓冲目录
rm -rf ~/.cache/matplotlib
#设置黑体到字库族列表中
cp -rf matplotlibrc  /usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/matplotlibrc
chmod 777 -R /usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/

echo "install font simhei.ttf  is finish."

#使Linux终端（Xshell telnet等）可以用 matplotlib库 画图。设置如下：
#Linux终端没有GUI，如何使用matplotlib绘图
#Linux中，创建文件 ~/.config/matplotlib/matplotlibrc
#添加如下一行：backend : Agg
mkdir -p ~/.config/matplotlib/
cp -rf matplotlibrc.config  	~/.config/matplotlib/matplotlibrc
echo "add shell, make telnet(shell commond ) can run matplotlibrc lib."


#安装ImageMagick
rm -rf ImageMagick-7.0.7-27
tar -xzvf ImageMagick-7.0.7-27.tar.gz
cd ImageMagick-7.0.7-27

if [ -d /usr/local/ImageMagick ]
then
	rm -rf  /usr/local/ImageMagick
else
	echo "/usr/local/ImageMagick is not exist."
fi

#生成动态库*.so,同时也生成静态库*.a
#./configure --prefix=/usr/local/python3 --enable-shared CFLAGS=-fPIC && make && make install
./configure --prefix=/usr/local/ImageMagick && make && make install
cd ..


#查看版本python 
python -V
#查看版本matplotlib
echo "matplotlib"
python -c "import matplotlib; print (matplotlib.__version__)"
#查看ImageMagick安装的版本
convert -version
echo "install matplotlib-2.2.2 is finish."


