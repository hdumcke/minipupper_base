#!/bin/bash

set -e

### Get directory where this script is installed
BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <ssid> <wifi password>"
    exit 1
fi

############################################
# wait until unattended-upgrade has finished
############################################
tmp=$(ps aux | grep unattended-upgrade | grep -v unattended-upgrade-shutdown | grep python | wc -l)
[ $tmp == "0" ] || echo "waiting for unattended-upgrade to finish"
while [ $tmp != "0" ];do
sleep 10;
echo -n "."
tmp=$(ps aux | grep unattended-upgrade | grep -v unattended-upgrade-shutdown | grep python | wc -l)
done

### Give a meaningfull hostname
echo "minipupper" | sudo tee /etc/hostname

### Setup wireless networking ( must change SSID and password )

sudo sed -i "/version: 2/d" /etc/netplan/50-cloud-init.yaml
echo "    wifis:" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "        wlan0:" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "            access-points:" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "                $1:" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "                    password: \"$2\"" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "            dhcp4: true" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "            optional: true" | sudo tee -a /etc/netplan/50-cloud-init.yaml
echo "    version: 2" | sudo tee -a /etc/netplan/50-cloud-init.yaml

### upgrade Ubuntu and install required packages

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
sed "s/deb/deb-src/" /etc/apt/sources.list | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt -y upgrade
sudo apt install -y i2c-tools dpkg-dev curl python-is-python3 mpg321 python3-tk
sudo sed -i "s/pulse/alsa/" /etc/libao.conf

### Install
for dir in IO_Configuration FuelGauge System EEPROM; do
    cd $BASEDIR/$dir
    ./install.sh
done

sudo sed -i "s|BASEDIR|$BASEDIR|" /etc/rc.local
sudo sed -i "s|BASEDIR|$BASEDIR|" /usr/bin/battery_monitor

### Install pip
sudo apt install -y python3-pip python3-dev
sudo -H python3 -m pip install --upgrade pip

### Install LCD driver
sudo git config --global add safe.directory $BASEDIR # temporary fix https://bugs.launchpad.net/devstack/+bug/1968798
sudo -H python3 -m pip install $BASEDIR/python_module
