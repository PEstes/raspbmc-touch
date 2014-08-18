#!/bin/bash
echo "toubleshooting touchscreen calibration"
if [ ! -f /etc/pointercal ]; then
echo "downloading & installing evtest"
sudo apt-get install evtest
echo "running  evtest, if uimapper is running there should be an entry called "uimapper - touchscreen"
evtest"
echo "if theres no uimapper present -> uimapper is not starting right"
echo "if theres no touchscreen present check your usb cable, maybe switch ports"




else
echo "pointercal file isnt present"
echo "run touchscreen installation first"





fi
