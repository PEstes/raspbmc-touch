#!/bin/bash
if [ ! -f  /etc/udev/rules.d/95egalax.rules ]; 
then
  echo "Based on XBian touch installer by brantje edited by Schlump for raspbmc"

  echo "Generating udev rule"
  echo "SUBSYSTEM==\"input\", ATTRS{name}==\"*eGalax Inc. USB TouchController*\",  ENV{DEVNAME}==\"*event*\", SYMLINK+=\"input/touchscreen\"" >> 95egalax.rules

  echo "Moving file..."
  sudo mv 95egalax.rules /etc/udev/rules.d/
  sudo reload udev
  cd /dev/input
  ls 
  echo "now there should be a symlink to touchscreen"
fi

  if [ ! -f /etc/pointercal ]; 
  then
    sudo stop xbmc
    echo "Getting tslib"
    wget --no-check -O tslib_1-1_armhf.deb "https://github.com/Schlump/raspbmc-touch/raw/master/tslib_1-1_armhf.deb"
    echo "Installing tslib"
    dpkg -i tslib_1-1_armhf.deb
    export LD_LIBRARY_PATH=/usr/local/lib
    export TSLIB_CONSOLEDEVICE=none
    export TSLIB_FBDEVICE=/dev/fb0
    export TSLIB_TSDEVICE=/dev/input/touchscreen
    export TSLIB_CALIBFILE=/etc/pointercal
    export TSLIB_CONFFILE=/usr/local/etc/ts.conf
    export TSLIB_PLUGINDIR=/usr/local/lib/ts
    echo "Please follow the instructions on the display..."
    ts_calibrate
    echo "Getting uimapper..."
    wget --no-check -O uimapper.tar.gz "https://github.com/Schlump/raspbmc-touch/raw/master/uinput-mapper.tar.gz"
    echo "Installing uimapper..."
    sudo mkdir -p /scripts && sudo tar -zxf uimapper.tar.gz -C /scripts
    echo "Generating config file"
    echo "#!upstart
    description \"uimapper\"
    env UIMAPPER_DEV=\"/dev/input/touchscreen\"
    env UIMAPPER_CONF=\"configs/touchscreen.py\"
    env UIMAPPER_DIR=\"/scripts/uinput-mapper\"
    start on startup or virtual-filesystems or (input-device-added SUBSYSTEM=input)
    stop on input-device-removed
    nice -10
    kill timeout 1
    expect fork
    script
    chdir \$UIMAPPER_DIR
    exec ./input-read.py \$UIMAPPER_DEV -D | ./input-create.py \$UIMAPPER_CONF &
    end script
    respawn" >> uimapper.conf
    echo "Moving config..."
    sudo mv uimapper.conf /etc/init
    sudo chmod +x /scripts/uinput-mapper/input-create.py
    sudo chmod +x /scripts/uinput-mapper/input-read.py
    echo "Cleaning up..."
    rm uimapper.tar.gz
    rm tslib_1-1_armhf.deb > /dev/null #Silent error
    sudo start uimapper
    sudo start xbmc
    echo "Installation done!"
      else
      echo "Already installed... Recalibrating"
      read inputnumber
      sudo stop xbmc
      sudo stop uimapper
      export LD_LIBRARY_PATH=/usr/local/lib
      export TSLIB_CONSOLEDEVICE=none
      export TSLIB_FBDEVICE=/dev/fb0
      export TSLIB_TSDEVICE=/dev/input/touchscreen
      export TSLIB_CALIBFILE=/etc/pointercal
      export TSLIB_CONFFILE=/usr/local/etc/ts.conf
      export TSLIB_PLUGINDIR=/usr/local/lib/ts
      sleep 3
      echo "Please follow the instructions on the display..."
      ts_calibrate
      sudo start uimapper
      sudo start xbmc
    
fi
