#!/bin/bash

rcfile=rc.local
tmp=/tmp/
interlinq=/interliNQ
npm=$interlinq/.npm
ucontrol=$interlinq/ucontrol-client

#echo 'Commenting the /etc/rc.local file'
#sudo sed -E -i -e 's/FOREVER_ROOT|#FOREVER_ROOT/#FOREVER_ROOT/' -e 's/DEBUG|#DEBUG/#DEBUG/' $rcfile

USB_DEV="$(sudo cat /proc/mounts | grep "${interlinq}" | cut -d" " -f1 | tr -d '\n')"

if [ -z "$USB_DEV" ]; then
  echo "No usb device found!"
  exit 1
else
  echo "USB device found: ${USB_DEV}."
fi

MONITOR_SEARCH="$(ps aux | grep nodejs | wc -l)"
if [ $MONITOR_SEARCH -eq 5 ]; then
  echo "Found ${MONITOR_SEARCH} monitor processes"
  echo "Killing all monitoring processe..."
  sudo pkill -f nodejs
else
  echo 'No monitoring processes found!'
fi


echo "Copying ${npm} folder..."
sudo cp -a $npm $tmp 
if [ "$?" -ne 0 ]; then echo "Copying ${npm} failed"; exit 1; fi

echo "Copying ${ucontrol} folder..."
sudo cp -a $ucontrol $tmp
if [ "$?" -ne 0 ]; then echo "Copying ${ucontrol} failed"; exit 1; fi

echo "Formatting the USB drive "
