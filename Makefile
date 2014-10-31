# Uncomment the following to enable debug.
#DEBUG = y

KVER := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/input/keyboard
MODULE_NAME := aziokbd

ifeq ($(DEBUG),y)
        DBGFLAGS = -O -g -DML_DEBUG
else
        DBGFLAGS = -O2
endif

ccflags-y += $(DBGFLAGS)


ifneq ($(KERNELRELEASE),)
        obj-m := $(MODULE_NAME).o
else
        KSRC := /lib/modules/$(KVER)/build
        PWD := $(shell pwd)

default:
	$(MAKE) -C $(KSRC) M=$(PWD) modules

clean:
	$(MAKE) -C $(KSRC) M=$(PWD) clean

uninstall:
	rm -f $(MODDESTDIR)/$(MODULE_NAME).ko
	/sbin/depmod -a ${KVER}

install:
	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)
	/sbin/depmod -a ${KVER}

	# Hmmm... not removed on uninstall...
	echo 'options usbhid quirks=0x0c45:0x7603:0x0007' >> /etc/modprobe.d/usbhid.conf
	echo 'aziokbd' >> /etc/modules
        
endif
