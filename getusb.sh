#!/bin/bash
interlinq=/interliNQ

USB_DEV="$(sudo cat /proc/mounts | grep "${interlinq}" | cut -d" " -f1 | tr -d '\n')"

if [ -z "$USB_DEV" ]; then
  echo "No usb device found!"
  exit 1
else
  echo "USB device found: ${USB_DEV}."
fi

