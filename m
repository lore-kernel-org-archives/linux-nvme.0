From: brown@freenet.carleton.ca (peter brown)
Date: Thu, 3 Sep 2015 23:57:22 -0400
Subject: Does /dev/nvme0n1p1 take a long time to created in /dev/ on boot?
Message-ID: <55E916A2.5090005@freenet.carleton.ca>

Hi,

 I'm having several problems with a new Intel 750 ssd device
on a linux 4.2.0 kernel (or 4.1.6).

 I'm trying to use the 750 ssd as the root file system. I'm using an initramfs
created via genkernel. I cannot boot from the ssd because the motherboard
bios does not support nvme.

 The os gets booted fine and the temporary root file system (initramfs) is
loaded and the the linuxrc script tries to mount /dev/nvme0n1p1.. and fails.

 It seems it cannot find /dev/nvme0n1p1. It then allows the user to drop into a
shell... which can see /dev/nvme0n1p1. After exiting the shell I can manually
enter the root file system name as "/dev/nvme0n1p1" and things boot fine.

 I modified the linuxrc script to wait 3 seconds before attempting to mount
/dev/nvme0n1p1 and sometimes it works and sometimes it fails. If it fails then
I can manually enter the root file system which then works fine.

 I guess I could add more delay but I find this very unusual.
I'm wondering if this has been seen before or what the cause could be.

 If I try and use the 750 ssd as the root file system without the initramfs
method the boot fails with the unknown root device. (This is from my bad memory
and I have no logs etc.). This is kinda like the inintramfs method but without
the opportunity to retry.

 Note that the nvme driver is not compiled as a module. Also, I'm not aware of
any other settings for the nvme driver.

 As a side note... I'm wondering if the 720 ssd card is broken.
I'm getting very very poor performance from the card. It works
(no bad logs in syslog) but the device is almost as slow as my
Seagate hard drive!

hdparm -tT /dev/nvme0n1p1
/dev/nvme0n1p1:
 Timing cached reads:   28348 MB in  2.00 seconds = 14188.57 MB/sec
 Timing buffered disk reads: 434 MB in  3.01 seconds = 144.25 MB/sec


hdparm -tT /dev/sdc (seagate drive)
/dev/sdc:
 Timing cached reads:   29430 MB in  2.00 seconds = 14730.72 MB/sec
 Timing buffered disk reads: 380 MB in  3.00 seconds = 126.49 MB/sec

 This is on a gentoo system running linux 4.2.0.
The motherboard is a p9x79 and the 750 ssd is installed in
a pcie 3.0x16 slot (second video card slot). It was also in the 3rd pcie 3 video
card slot with the same poor performance.

 Any suggestions would be appreciated.

 -pb
