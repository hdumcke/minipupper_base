# minipupper_base

Proposal for Mangdang, work in progress. 

Main changes:

- clean repository
- contains only the code required to get the hardware API installed
- installs on clean Unutu 20.04 (Raspberry Pi)
- Python code is installed as a Python module
- No root priviledges required to drive any robot API
- calibrate is a system command

## Installation

- flash  Ubuntu server 20.04 64bit to SD card
- boot Raspberry Pi connected to Ethernet
- ssh ubuntu@<raspi ip address> 
- change password (default is ubuntu)
- clone this repository with git clone https://github.com/hdumcke/minipupper_base.git
- ./minipupper_base/install.sh  <my SSID> <my wifi password>
- reboot
- ./minipupper_base/update_kernel_modules.sh
- reboot
- ./minipupper_base/test.sh

## Calibrate

- ssh -Y ubuntu@<raspi WiFi address>
- calibrate # this is a command
