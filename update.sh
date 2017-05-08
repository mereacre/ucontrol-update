#!/bin/bash

rcfile=rc.local
monitorproc=monitor.js
tmp=/tmp
interlinq=/interliNQ
npmname=.npm
npm=$interlinq/$npmname
forever=$interlinq/.forever
ucontrolname=ucontrol-client
ucontrol=$interlinq/$ucontrolname
tmpforever=$tmp/.forever
bootscript=$ucontrol/boot/boot.js
transmitname=transmit
pendingname=pending
transmit=$ucontrol/monitor/$transmitname
pending=$ucontrol/monitor/$pendingname


if [ ! -d "$tmp" ]; then
  echo "Folder $tmp does not exist!"
  exit 1
fi

if [ ! -d "$interlinq" ]; then
  echo "Folder $interlinq does not exist!"
  exit 1
fi

USB_DEV="$(sudo cat /proc/mounts | grep "${interlinq}" | cut -d" " -f1 | tr -d '\n')"

if [ -z "$USB_DEV" ]; then
  echo "No usb device found!"
  exit 1
else
  echo "USB device found: ${USB_DEV}."
fi

MONITOR_SEARCH="$(ps aux | grep ${monitorproc} | wc -l)"
if [ $MONITOR_SEARCH -eq 3 ]; then
  echo "Found ${MONITOR_SEARCH} monitor processes"
  echo "Killing all monitoring processe..."
  sudo pkill -f $monitorproc
else
  echo 'No monitoring processes found!'
fi

echo "Changing boot script file ${bootscript}..."
sudo sed -E -i -e "s|$forever|$tmpforever|" $bootscript

echo "Copying ${npm} folder to ${tmp}..."
sudo cp -a $npm $tmp 
if [ "$?" -ne 0 ]; then echo "Copying ${npm} failed"; exit 1; fi

echo "Copying ${ucontrol} folder to ${tmp}..."
sudo cp -a $ucontrol $tmp
if [ "$?" -ne 0 ]; then echo "Copying ${ucontrol} failed"; exit 1; fi

echo "Formatting the USB drive "
# To simulate only
# Use proper format function
#sudo rm -rf ${npm}
#sudo rm -rf ${ucontrol}

echo "Copying to ${npm}..."
#sudo cp -a  ${tmp}/$npmname $npm

echo "Copying to ${ucontrol}..."
#sudo cp -a  ${tmp}/$ucontrolname $ucontrol

echo "Copying ${transmit} to ${tmp}..."
sudo cp -a ${transmit} ${tmp}

echo "Copying ${pending} to ${tmp}..."
sudo cp -a ${pending} ${tmp}

echo "Making link to ${transmit}..."
#sudo rm -rf ${transmit}
#sudo ln -s ${tmp}/${transmitname} ${transmit}

echo "Making link to ${pending}..."
#sudo rm -rf ${pending}
#sudo ln -s ${tmp}/${pendingname} ${pending}


