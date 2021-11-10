#!/bin/bash

echo "           _____        ______ _____   _____ ______  __          ______  _____  _  __ _____ _    _  ____  _____   ";
echo "     /\   |_   _| ____ |  ____|  __ \ / ____|  ____| \ \        / / __ \|  __ \| |/ // ____| |  | |/ __ \|  __ \  ";
echo "    /  \    | |  / __ \| |__  | |  | | |  __| |__     \ \  /\  / / |  | | |__) | ' /| (___ | |__| | |  | | |__) | ";
echo "   / /\ \   | | / / _\` |  __| | |  | | | |_ |  __|     \ \/  \/ /| |  | |  _  /|  <  \___ \|  __  | |  | |  ___/  ";
echo "  / ____ \ _| || | (_| | |____| |__| | |__| | |____     \  /\  / | |__| | | \ \| . \ ____) | |  | | |__| | |      ";
echo " /_/    \_\_____\ \__,_|______|_____/ \_____|______|     \/  \/   \____/|_|  \_\_|\_\_____/|_|  |_|\____/|_|      ";
echo "                 \____/                                                                                           ";
echo "                                                                                                                  ";

sudo apt update
sudo apt upgrade -y
sudo apt install python3 python3-pip -y

pip3 install jupyter

sudo pip uninstall tensorflow
sudo pip3 uninstall tensorflow
# install the dependencies (if not already onboard)
sudo apt-get install gfortran -y
sudo apt-get install libhdf5-dev libc-ares-dev libeigen3-dev -y
sudo apt-get install libatlas-base-dev libopenblas-dev libblas-dev -y
sudo apt-get install liblapack-dev -y
# upgrade setuptools 47.1.1 -> 50.3.2
sudo -H pip3 install --upgrade setuptools
sudo -H pip3 install pybind11
sudo -H pip3 install Cython==0.29.21
# install h5py with Cython version 0.29.21 (± 6 min @1950 MHz)
sudo -H pip3 install h5py==2.10.0
# install gdown to download from Google drive
pip3 install gdown

source ~/.profile 

# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-aarch64.sh -O ~/miniconda.sh
# bash ~/miniconda.sh -b -p $HOME/miniconda
# eval "$($HOME/miniconda/bin/conda shell.bash hook)"

sudo apt install gcc-arm-none-eabi mercurial -y
pip3 install mbed-cli


# gdown https://drive.google.com/uc?id=1BLXP7RKEfTp9fxbmI8Qu2FdhU7NUxcwV

# sudo -H pip3 install tensorflow-2.6.0-cp37-cp37m-linux_aarch64.whl

# download the wheel
gdown https://drive.google.com/uc?id=1WDG8Rbi0ph0sQ6TtD3ZGJdIN_WAnugLO
# install TensorFlow 2.4.1 (± 68 min @1950 MHz)
sudo -H pip3 install tensorflow-2.4.1-cp37-cp37m-linux_aarch64.whl


echo "-----------------------------------------------------------"
echo " Done !"
echo "-----------------------------------------------------------"
