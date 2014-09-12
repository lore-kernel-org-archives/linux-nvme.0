From: haomaiwang@gmail.com (Haomai Wang)
Date: Fri, 12 Sep 2014 12:23:43 +0800
Subject: Unable to find /dev/nvme0
Message-ID: <CACJqLyZp4J-yxc=KEnTJ=yg3hJZGRu2UQD2B39qzbnq3cdzMJw@mail.gmail.com>

Hi,

I use a linux kernel version 3.12 based on CentOS 6.5:
# uname -a
Linux server-72 3.12.21-1.el6.x86_64 #1 SMP Thu Jun 5 22:15:05 EDT
2014 x86_64 x86_64 x86_64 GNU/Linux

I insert kernel module nvme:
# modprobe nvme
# lsmod | grep nvme
nvme                   54575  0
# modinfo nvme
filename:       /lib/modules/3.12.21-1.el6.x86_64/kernel/drivers/block/nvme.ko
version:        0.8
license:        GPL
author:         Matthew Wilcox <willy at linux.intel.com>
srcversion:     971AB1E47B949401886CC3F
alias:          pci:v*d*sv*sd*bc01sc08i02*
depends:
intree:         Y
vermagic:       3.12.21-1.el6.x86_64 SMP mod_unload modversions
parm:           nvme_major:int
parm:           use_threaded_interrupts:int

I follow the instructment from
(file:///Users/wanghaomai/Downloads/SF13_SSDL001_100.pdf) and can't
fiind:
# ls /dev/nvme*
ls: cannot access /dev/nvme*: No such file or directory

I used intel nvme p3500 for testing.

I'm very appreciated if any feedback

-- 
Best Regards,

Wheat
