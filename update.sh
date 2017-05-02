#!/bin/bash

rcfile=rc.local

echo 'Commenting the /etc/rc.local file'
sudo sed -E -i -e 's/FOREVER_ROOT|#FOREVER_ROOT/#FOREVER_ROOT/' -e 's/DEBUG|#DEBUG/#DEBUG/' $rcfile
