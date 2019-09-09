#!/bin/sh
#���в���ϵͳҪ��CentOS Linux release 7.2.1511 (Core) 

echo "start install python 3.6.4"
root_path="$PWD"
#<<COMMENT
chmod 777 -R ./

#��װPython-3.6.4
rm -rf Python-3.6.4
tar -xvf Python-3.6.4.tgz
cd Python-3.6.4


if [ -d /usr/local/python3 ]
then
	rm -rf  /usr/local/python3
else
	echo "/usr/local/python3 is not exist."
fi

#���ɾ�̬��*.a
#./configure --prefix=/usr/local/python3 && make && make install 
#���ɶ�̬��*.so
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


#��װ python��ͼ�õ���չ�� matplotlib-2.2.2.tar.gz
#���߰�װ
#yum install python-matplotlib
#pip install matplotlib

######################## ��װmatplotlib������ ########################################################################

<<COMMENT__Dependencies_matplotlib

#�Ȱ�װmatplotlib-2.2.2�������Ŀ�
Dependencies
Matplotlib requires a large number of dependencies:
13��������

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

#��װ numpy-1.11.2.tar.gz
#1.����Դ�����wget http://jaist.dl.sourceforge.net/project/numpy/NumPy/1.9.0/numpy-1.9.0.zip
tar -xzvf numpy-1.11.2.tar.gz
cd numpy-1.11.2
python setup.py install
#numpy�����Ƿ�װ�ɹ���python && from numpy import *  && eye(4) 
cd ../

#��װ kiwisolver-1.0.1.tar.gz
#https://pypi.python.org/pypi/kiwisolver/1.0.1
tar -xzvf kiwisolver-1.0.1.tar.gz
cd kiwisolver-1.0.1
python setup.py install
cd ../

#��װ six-1.11.0.tar.gz
#https://pypi.python.org/pypi/six/1.11.0
tar -xzvf six-1.11.0.tar.gz
cd six-1.11.0
python setup.py install
cd ../

#��װ pytz-2018.4.tar.gz
#https://pypi.python.org/pypi/pytz/2018.4
tar -xzvf pytz-2018.4.tar.gz
cd pytz-2018.4
python setup.py install
cd ../

#��װ setuptools_scm-2.0.0.tar.gz
#https://pypi.python.org/pypi/setuptools-scm-about/1.0
tar -xzvf setuptools_scm-2.0.0.tar.gz
cd setuptools_scm-2.0.0
python setup.py install
cd ../

#��װ python-dateutil-2.7.2.tar.gz
#https://pypi.python.org/pypi/python-dateutil/2.7.2
tar -xzvf python-dateutil-2.7.2.tar.gz
cd python-dateutil-2.7.2
python setup.py install
cd ../

#��װ pyparsing-2.2.0.tar.gz
#https://pypi.python.org/pypi/pyparsing/2.2.0
tar -xzvf pyparsing-2.2.0.tar.gz
cd pyparsing-2.2.0
python setup.py install
cd ../

#��װ cycler-0.10.0.tar.gz
#https://pypi.python.org/pypi/Cycler/0.10.0
tar -xzvf cycler-0.10.0.tar.gz
cd cycler-0.10.0
python setup.py install
cd ../

######################## end ��װmatplotlib������ ########################################################################

#���߰�װ matplotlib-2.2.2.tar.gz
rm -rf matplotlib-2.2.2
tar -xzvf matplotlib-2.2.2.tar.gz
cd matplotlib-2.2.2
python setup.py build
python setup.py install
cd ../

#����������ȷ��װ matplotlib-2.2.2.tar.gz
#python -c "import matplotlib; print (matplotlib.__version__)"

#1>  fgf�鿴python,numpy,scipy,matplotlib�İ汾����װλ�� 
#        1���鿴python�汾
#        ����python -V
#        ����python --version
#        2���鿴python��װλ��
#            python -c "import sys; print (sys.executable)"
#        ����python -c "import os; print (os.sys.executable)"
#        3���鿴Numpy�汾
#            python -c "import numpy; print (numpy.version.version)"
#            python -c "import numpy; print (numpy.__version__)"
#        4���鿴Numpy��װ·��
#            python -c "import numpy; print (numpy.__file__)"
#        5���鿴SciPy�汾
#            python -c "import scipy; print (scipy.version.version)"
#        6���鿴SciPy��װ·��
#            python -c "import scipy; print (scipy.__file__)"
#        7���鿴Matplotlib�汾
#            python -c "import matplotlib; print (matplotlib.__version__)"
#        8���鿴Matplotlib��װ·��
#            python -c "import matplotlib; print (matplotlib.matplotlib_fname())"

#[root@linuxprobe python]# python -c "import matplotlib; print (matplotlib.matplotlib_fname())"
#/usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/matplotlibrc
#/usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/
#/usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data

#���׽��matplotlib������������             ->  �����ӽ���취
#��װ����
cp -rf simhei.ttf  /usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/fonts/ttf/simhei.ttf
#Ȼ��ɾ��~/.cache/matplotlib�Ļ���Ŀ¼
rm -rf ~/.cache/matplotlib
#���ú��嵽�ֿ����б���
cp -rf matplotlibrc  /usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/matplotlibrc
chmod 777 -R /usr/local/python3/lib/python3.6/site-packages/matplotlib-2.2.2-py3.6-linux-x86_64.egg/matplotlib/mpl-data/

echo "install font simhei.ttf  is finish."

#ʹLinux�նˣ�Xshell telnet�ȣ������� matplotlib�� ��ͼ���������£�
#Linux�ն�û��GUI�����ʹ��matplotlib��ͼ
#Linux�У������ļ� ~/.config/matplotlib/matplotlibrc
#�������һ�У�backend : Agg
mkdir -p ~/.config/matplotlib/
cp -rf matplotlibrc.config  	~/.config/matplotlib/matplotlibrc
echo "add shell, make telnet(shell commond ) can run matplotlibrc lib."


#��װImageMagick
rm -rf ImageMagick-7.0.7-27
tar -xzvf ImageMagick-7.0.7-27.tar.gz
cd ImageMagick-7.0.7-27

if [ -d /usr/local/ImageMagick ]
then
	rm -rf  /usr/local/ImageMagick
else
	echo "/usr/local/ImageMagick is not exist."
fi

#���ɶ�̬��*.so,ͬʱҲ���ɾ�̬��*.a
#./configure --prefix=/usr/local/python3 --enable-shared CFLAGS=-fPIC && make && make install
./configure --prefix=/usr/local/ImageMagick && make && make install
cd ..


#�鿴�汾python 
python -V
#�鿴�汾matplotlib
echo "matplotlib"
python -c "import matplotlib; print (matplotlib.__version__)"
#�鿴ImageMagick��װ�İ汾
convert -version
echo "install matplotlib-2.2.2 is finish."


