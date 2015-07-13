From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Mon, 13 Jul 2015 19:50:41 +0100
Subject: Partitions and end-to-end protection
Message-ID: <55A40881.5000108@ranbarg.com>

Hi All,

I've had a problem reported against the NVMe driver on the v4.1 kernel.
The user has formatted a namespace with 512 byte sectors, separate
buffer 8 byte meta-data and protection type 1.
That should all be okay, and indeed reads and writes work fine.
However, if a partition table is created in the namespace and then the
machine is rebooted, or the driver is unloaded and loaded, the
partitions don't appear again unless they are manually probed.

What seems to be happening is that the driver starts off by setting the
capacity to zero whilst it validates the meta-data configuration and
then sets the real size after this validation. However, setting the
capacity does not seem to be enough to tell the kernel to re-read the
partition table.

Anyone else seeing this?

Thanks,

Paul.
