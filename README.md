# Linux Microdia Keyboard Chipset Driver #

For Chipset `0x0c45`:`0x7603`

Written for the Azio L70 USB Keyboard: [L70 USB Backlit Gaming Keyboard (KB501)](http://www.aziocorp.com/en/keyboards/23-l70-usb-backlit-gaming-keyboard-kb501-0676151010719.html)

> NOTE: Makefile and instructions are only tested on Ubuntu, however they are known to work on Debian.

# Installation ##
## DKMS ##

    sudo apt-get install mercurial build-essential linux-headers-generic dkms
    hg clone https://bitbucket.org/Swoogan/aziokbd
    cd aziokbd
    sudo ./install.sh dkms

## Manual Install ##

    sudo apt-get install mercurial build-essential linux-headers-generic
    hg clone https://bitbucket.org/Swoogan/aziokbd
    cd aziokbd
    sudo ./install.sh

# Blacklisting #

**NOTE: install.sh attempts to blacklist the driver for you. You shouldn't need to do anything manually. These instructions are to explain the process, in the event something goes wrong.**

You need to blacklist the device from the generic USB hid driver in order for the aziokbd driver to control it.

## Kernel Module ##
If the USB hid driver is compiled as a kernel module you will need to create a quirks file and blacklist it there.

You can determine if the driver is a module by running the following:

    lsmod | grep usbhid

If `grep` finds something, it means that the driver is a module.

Create a file called `/etc/modprobe.d/usbhid.conf` and add the following to it:

    options usbhid quirks=0x0c45:0x7603:0x0004

If you find that the generic USB driver is still taking the device, try changing the `0x0004` to a `0x0007`.

## Compiled into Kernel ##
If the generic USB hid driver is compiled into the kernel, then the driver is not loaded as a module and setting the option via `modprobe` will not work. In this case you must pass the option to the driver via the grub boot loader.

Create a new file in `/etc/default/grub.d/`. For example, you might call it `aziokbd.conf`. (If your grub package doesn't have this directory, just modify the generic `/etc/default/grub` configuration file):

    GRUB_CMDLINE_LINUX_DEFAULT='usbhid.quirks=0x0c45:0x7603:0x4'

Then run `sudo update-grub` and reboot.

Again, if you find that `0x4` doesn't work, try `0x7`.

