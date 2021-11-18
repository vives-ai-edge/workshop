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

sudo apt install git -y

# install python3 (needs to be python 3.7 for tensorflow)
sudo apt install python3 python3-pip -y

# Install jupyter notebook
sudo apt install libffi-dev -y
sudo -H pip3 install jupyter
sudo -H pip3 install pygments==2.4.1

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

sudo -H pip3 install numpy==1.19.5
sudo -H pip3 install matplotlib pandas

# gdown https://drive.google.com/uc?id=1BLXP7RKEfTp9fxbmI8Qu2FdhU7NUxcwV

# sudo -H pip3 install tensorflow-2.6.0-cp37-cp37m-linux_aarch64.whl
sudo -H pip3 install gdown

source ~/.profile 

# download the wheel
gdown https://drive.google.com/uc?id=1WDG8Rbi0ph0sQ6TtD3ZGJdIN_WAnugLO
# install TensorFlow 2.4.1 (± 68 min @1950 MHz)
sudo -H pip3 install tensorflow-2.4.1-cp37-cp37m-linux_aarch64.whl

# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-aarch64.sh -O ~/miniconda.sh
# bash ~/miniconda.sh -b -p $HOME/miniconda
# eval "$($HOME/miniconda/bin/conda shell.bash hook)"

sudo apt install mercurial -y

# sudo apt install gcc-arm-none-eabi -y
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2
tar xjvf gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2 # -C /usr/share/bin/
sudo cp -r gcc-arm-none-eabi-9-2020-q2-update/* /usr/
sudo rm -r gcc-arm-none-eabi-9-2020-q2-update
sudo rm gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2

sudo apt-get install python3-venv -y

python3 -m venv ~/.venv/mbed

source ~/.venv/mbed/bin/activate

pip3 install mbed-cli

cat > /home/pi/Desktop/mbed-cli <<EOF
[Desktop Entry]
Comment=mbed-cli in venv terminal
Terminal=false
Name=mbed-cli
Exec=lxterminal -e "echo This is a console with mbed-cli enabled;source $HOME/.venv/mbed/bin/activate;$SHELL"
Type=Application
Icon=/usr/share/icons/Adwaita/512x512/apps/utilities-terminal.png
EOF

# Install nodejs

curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install -g npm

sudo npm install -g edge-impulse-cli

git clone

# Install workshop materials

sudo mkdir /home/pi/workshop-ai-edge
sudo chown pi:pi /home/pi/workshop-ai-edge
cd /home/pi/workshop-ai-edge

git clone https://github.com/sillevl/tensorflow-lite-micro-hello-world-mbed.git
git clone https://github.com/vives-ai-edge/accelero-data-forwarder.git
git clone https://github.com/edgeimpulse/example-standalone-inferencing-mbed.git


echo "-----------------------------------------------------------"
echo " Done !"
echo "-----------------------------------------------------------"
