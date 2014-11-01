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

dkms:  clean
	rm -rf /usr/src/$(MODULE_NAME)-1.0.0
	mkdir /usr/src/$(MODULE_NAME)-1.0.0 -p
	cp . /usr/src/$(MODULE_NAME)-1.0.0 -a
	rm -rf /usr/src/$(MODULE_NAME)-1.0.0/.hg
	dkms add -m $(MODULE_NAME) -v 1.0.0
	dkms build -m $(MODULE_NAME) -v 1.0.0
	dkms install -m $(MODULE_NAME) -v 1.0.0 --force

endif
