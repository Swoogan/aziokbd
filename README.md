# Linux Azio L70 USB Keyboard Driver #

NOTE: Makefile and instructions are only tested on Ubuntu.

    make
    sudo make install
    echo 'options usbhid quirks=0x0c45:0x7603:0x0007' > /etc/modprobe.d/usbhid.conf

