# Linux Azio L70 USB Keyboard Driver #

[L70 USB Backlit Gaming Keyboard (KB501)](http://www.aziocorp.com/en/keyboards/23-l70-usb-backlit-gaming-keyboard-kb501-0676151010719.html)

NOTE: Makefile and instructions are only tested on Ubuntu.

    make
    sudo make install
    echo 'options usbhid quirks=0x0c45:0x7603:0x0007' >> /etc/modprobe.d/usbhid.conf

If the keyboard still isn't blacklisted from the generic usb hid driver, change the 0x0007 in the quirks to 0x0004.
