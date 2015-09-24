From: jeg@amazon.com (Gu, Jerry)
Date: Thu, 24 Sep 2015 20:55:09 +0000
Subject: Adding IOCTL for NVMe controller reset
Message-ID: <ee3333b3a0ae4f878f4903ffe8ce547f@EX13D05UWC003.ant.amazon.com>

I was wondering what's the latest about adding an IOCTL to reset NVMe controller as described in this thread:
http://lists.infradead.org/pipermail/linux-nvme/2015-March/001611.html
Is there a patch available yet?

This is very useful to finish a firmware upgrade without power-cycling the host on some old kernel where the sysfs method doesn't work.

Thanks!
Jerry
