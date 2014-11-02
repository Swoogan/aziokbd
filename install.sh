#!/bin/bash

quirk='quirks=0x0c45:0x7603:0x0007'

if [[ $1 != 'dkms' ]]; then
   echo '## Making package ##'
   make

   echo '## Installing package ##'
   make install
else
   echo '## Installing package with DKMS ##'
   make dkms
fi

echo '## Writing to config ##'

# Making sure the quirk does not get added multiple times
if ! (cat /etc/modprobe.d/usbhid.conf | grep $quirk)
   then
   echo 'options usbhid' $quirk >> /etc/modprobe.d/usbhid.conf
   if [[ $1 != 'dkms' ]]; then sudo echo 'aziokbd' >> /etc/modules; fi
else
   echo 'NOTICE - Config files have already been updated'
fi

echo '## Starting module ##'
modprobe aziokbd

# Note: this line may fail if you have other drivers loaded that depend
# on usbhid. For example, your mouse driver. In that case you would have
# to remove those drivers first, then load them again.
echo '## Attempting to reload usbhid module ##'
rmmod usbhid && modprobe usbhid $quirk
