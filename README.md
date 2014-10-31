# Linux Azio L70 USB Keyboard Driver #

[L70 USB Backlit Gaming Keyboard (KB501)](http://www.aziocorp.com/en/keyboards/23-l70-usb-backlit-gaming-keyboard-kb501-0676151010719.html)

NOTE: Makefile and instructions are only tested on Ubuntu.

## DKMS ##

    sudo apt-get install mercurial build-essential linux-headers-generic dkms
    hg clone https://bitbucket.org/Swoogan/aziokbd
    cd aziokbd
    sudo make dkms

## Manual Install ##

    sudo apt-get install mercurial build-essential linux-headers-generic
    hg clone https://bitbucket.org/Swoogan/aziokbd
    cd aziokbd
    make
    sudo make install

If the keyboard still isn't blacklisted from the generic usb hid driver, change the 0x0007 in the quirks to 0x0004.

