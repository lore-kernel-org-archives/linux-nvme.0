From: mr.nuke.me@gmail.com (Alex G.)
Date: Thu, 23 Aug 2018 10:03:11 -0500
Subject: Unloading nvme module after unbinding devices
Message-ID: <44e7c58a-7d68-0bdb-2adf-7a31eee91a28@gmail.com>

Hi,

I was trying to 'rmmod nvme' for testing reasons. As you guessed from me 
writing this message, it does not work. It seems very odd to me that a 
kernel module cannot be unloaded after all its devices have been 
unbound. I've only seen this before with buggy GPU drivers.
Is this by design, or do we have a genuine  bug?

Alex

# rmmod nvme
rmmod: ERROR: Module nvme is in use

# rmmod nvme_core
rmmod: ERROR: Module nvme_core is in use by: nvme

# lspci |grep nvme -i
3f:00.0 Non-Volatile memory controller: Intel Corporation Express Flash 
NVMe P4500
40:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller 172Xa/172Xb (rev 01)
b1:00.0 Non-Volatile memory controller: Intel Corporation Express Flash 
NVMe P4600
b2:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller 172Xa/172Xb (rev 01)

# echo 0000:3f:00.0 > /sys/bus/pci/drivers/nvme/unbind
# echo 0000:40:00.0 > /sys/bus/pci/drivers/nvme/unbind
# echo 0000:b1:00.0 > /sys/bus/pci/drivers/nvme/unbind
# echo 0000:b2:00.0 > /sys/bus/pci/drivers/nvme/unbind

# rmmod nvme
rmmod: ERROR: Module nvme is in use

# ls /sys/bus/pci/drivers/nvme/
bind  module  new_id  remove_id  uevent  unbind
#
