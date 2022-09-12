#!/usr/bin/env bash

clean="false"
if [ "$1" == "--clean" ]; then
  clean="true"
fi

# usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }

# while getopts ":hc" arg; do
#   case $arg in
#     c)
#       echo "clean mode activated"
#       clean="true"
#       ;;
#     h | *)
#       usage
#       exit 0
#       ;;
#   esac
# Done

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
sudo apt autoremove -y

sudo apt install git -y

# install python3 (needs to be python 3.7 for tensorflow)
sudo apt install python3 python3-pip -y
sudo -H pip3 install --upgrade pip

# Install jupyter notebook
# sudo apt install libffi-dev -y
sudo -H pip3 install jupyter
# sudo -H pip3 install pygments==2.4.1

# if [ ! -f "/home/pi/.jupyter/jupyter_notebook_config.py" ]; then
# jupyter-notebook --generate-config
# grep -qxF 'c.NotebookApp.open_browser = False' /home/pi/.jupyter/jupyter_notebook_config.py || echo "c.NotebookApp.open_browser = False" >>  /home/pi/.jupyter/jupyter_notebook_config.py
# fi

# Make sure older versions are not installed. Only 2.4.1 is allowed
# if ! (pip3 list | grep "tensorflow.*2\.4\.1" > /dev/null); then
#   sudo pip uninstall tensorflow
#   sudo pip3 uninstall tensorflow
# fi

# install the dependencies (if not already onboard)
# sudo apt-get install gfortran -y
# sudo apt-get install libhdf5-dev libc-ares-dev libeigen3-dev -y
# sudo apt-get install libatlas-base-dev libopenblas-dev libblas-dev -y
# sudo apt-get install liblapack-dev -y
# upgrade setuptools 47.1.1 -> 50.3.2
# sudo -H pip3 install --upgrade setuptools
# sudo -H pip3 install pybind11
# sudo -H pip3 install Cython==0.29.21
# install h5py with Cython version 0.29.21 (± 6 min @1950 MHz)
# sudo -H pip3 install h5py==2.10.0
# install gdown to download from Google drive

# sudo -H pip3 install numpy==1.19.5
# sudo -H pip3 install matplotlib pandas

# gdown https://drive.google.com/uc?id=1BLXP7RKEfTp9fxbmI8Qu2FdhU7NUxcwV

# sudo -H pip3 install tensorflow-2.6.0-cp37-cp37m-linux_aarch64.whl
# sudo -H pip3 install gdown

sudo -H pip3 install protobuf==3.19.4

# install tensorflow 2.7.0
git clone -b v0.23.1 --depth=1 --recursive https://github.com/tensorflow/io.git
cd io
python3 setup.py -q bdist_wheel --project tensorflow_io_gcs_filesystem
cd dist
sudo -H pip3 install tensorflow_io_gcs_filesystem-0.23.1-cp39-cp39-linux_aarch64.whl
cd ~/Documents
# install gdown to download from Google drive
sudo -H pip3 install gdown
# download the wheel
gdown https://drive.google.com/uc?id=1YpxNubmEL_4EgTrVMu-kYyzAbtyLis29
# install TensorFlow 2.8.0
sudo -H pip3 install tensorflow-2.8.0-cp39-cp39-linux_aarch64.whl

source ~/.profile 

# if [ ! -f "./tensorflow-2.4.1-cp37-cp37m-linux_aarch64.whl" ]; then
#   gdown https://drive.google.com/uc?id=1WDG8Rbi0ph0sQ6TtD3ZGJdIN_WAnugLO
# fi

# install TensorFlow 2.4.1 (± 68 min @1950 MHz)
# sudo -H pip3 install wrapt --upgrade --ignore-installed # fix bug
# sudo -H pip3 install tensorflow-2.4.1-cp37-cp37m-linux_aarch64.whl

# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-aarch64.sh -O ~/miniconda.sh
# bash ~/miniconda.sh -b -p $HOME/miniconda
# eval "$($HOME/miniconda/bin/conda shell.bash hook)"

sudo apt install mercurial -y

# sudo apt install gcc-arm-none-eabi -y
if [ ! -d "/usr/arm-none-eabi" ];
then
  wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2
  tar xjf gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2 # -C /usr/share/bin/
  sudo cp -r gcc-arm-none-eabi-9-2020-q2-update/* /usr/
  sudo rm -r gcc-arm-none-eabi-9-2020-q2-update
  sudo rm gcc-arm-none-eabi-9-2020-q2-update-aarch64-linux.tar.bz2
fi

sudo apt-get install python3-venv -y
sudo apt-get install code

python3 -m venv ~/.venv/mbed

source ~/.venv/mbed/bin/activate

pip3 install mbed-cli

mbed config --global toolchain GCC_ARM

cat > /home/pi/Desktop/mbed-cli <<EOF
[Desktop Entry]
Comment=mbed-cli in venv terminal
Terminal=false
Name=mbed-cli
Exec=lxterminal -e "echo This is a console with mbed-cli enabled;source $HOME/.venv/mbed/bin/activate;$SHELL"
Type=Application
Icon=/usr/share/icons/Adwaita/512x512/apps/utilities-terminal.png
EOF

sudo -H chmod +x /home/pi/Desktop/mbed-cli

# Install nodejs

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install -g npm

sudo npm install -g edge-impulse-cli

# Install workshop materials
if [ "${clean}" == "true" ]; then
  sudo rm -rf /home/pi/workshop-ai-edge
elif [ -d "/home/pi/workshop-ai-edge" ]; then
  echo "Workshop directory already exists. Run with -c if you wish to clean install."
  exit -1
fi

mkdir /home/pi/workshop-ai-edge
# sudo chown pi:pi /home/pi/workshop-ai-edge
cd /home/pi/workshop-ai-edge

git clone https://github.com/vives-ai-edge/tensorflow-lite-micro-hello-world-mbed.git
git clone https://github.com/vives-ai-edge/accelero-data-forwarder.git
git clone https://github.com/vives-ai-edge/AB-writing-standalone-inference-mbed.git

mkdir /home/pi/workshop-ai-edge/hello-world-jupyter-notebook
wget https://github.com/tensorflow/tflite-micro/raw/main/tensorflow/lite/micro/examples/hello_world/train/train_hello_world_model.ipynb -P /home/pi/workshop-ai-edge/hello-world-jupyter-notebook

source $HOME/.venv/mbed/bin/activate
cd /home/pi/workshop-ai-edge/tensorflow-lite-micro-hello-world-mbed
mbed deploy
cd mbed-os
pip3 install -r requirements.txt
cd ..
mbed config root .
mbed target NUCLEO_L476RG
mbed toolchain GCC_ARM

cd /home/pi/workshop-ai-edge/accelero-data-forwarder
mbed deploy
cd mbed-os
pip3 install -r requirements.txt
cd ..
mbed config root .
mbed target NUCLEO_L476RG
mbed toolchain GCC_ARM

cd /home/pi/workshop-ai-edge/AB-writing-standalone-inference-mbed
mbed deploy
cd mbed-os
pip3 install -r requirements.txt
cd ..
mbed config root .
mbed target NUCLEO_L476RG
mbed toolchain GCC_ARM

# update for markupsafe version
# python -m pip install markupsafe==2.0.1

echo "-----------------------------------------------------------"
echo " Done !"
echo "-----------------------------------------------------------"
