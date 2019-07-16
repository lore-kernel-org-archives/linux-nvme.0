From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Jul 2019 11:04:36 +1000
Subject: nvme-5.3 ssd performance regression
Message-ID: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>

Hi !

Something I noticed while testing those patches for the Apple drives.

With 5.2.0 (and those patches):

[benh at mini ~]$ sudo hdparm -tf /dev/nvme0n1

/dev/nvme0n1:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads: 5960 MB in  3.00 seconds = 1986.22 MB/sec

(The numbers are reasonably stable accross multiple runs)

With nvme-5.3 (and those patches & the ctrl->opts NULL fix)

[benh at mini linux]$ sudo hdparm -tf /dev/nvme0n1

/dev/nvme0n1:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads: 4520 MB in  3.00 seconds = 1506.63 MB/sec
[benh at mini linux]$ sudo hdparm -tf /dev/nvme0n1

Here too, the numbers are quite stable during a given boot but
interestingly they seem to change from boot to boot, I also observed
1700 MB/s for example. It's a rather major regression.

The .config is identical in both cases (an x86_64-defconfig with a
small tweak or two, I removed more drivers mostly and made nvme a
module)

In both cases the io scheduler is mq-deadline. The device has a single
IO queue.

Cheers,
Ben.
