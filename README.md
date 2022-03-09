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
- ssh ubuntu@<lt;raspi ip address>gt; 
- change password (default is ubuntu)
- clone this repository with git clone https://github.com/hdumcke/minipupper_base.git
- ./minipupper_base/install.sh  <lt;my SSID>gt; <lt;my wifi password>gt;
- reboot
- ./minipupper_base/update_kernel_modules.sh
- reboot
- ./minipupper_base/test.sh

## Calibrate

- ssh -Y ubuntu@<lt;raspi WiFi address>gt;
- calibrate # this is a command

## To Do

- add documentation

