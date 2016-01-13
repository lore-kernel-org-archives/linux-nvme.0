From: stephen@networkplumber.org (Stephen Hemminger)
Date: Tue, 12 Jan 2016 19:40:30 -0800
Subject: NVM and swap device
Message-ID: <20160112194030.5b74ecdc@xeon-e3>

I have a nice shiny new Intel NVM PCI card; decided to use it for a filesystem and swap.
The filesystem (btrfs) is doing fine, but the swap device was throwing occasional
random errors. Suspect a driver problem rather than hardware.

I am using 4.4 kernel without patches.

kern.log:Jan 12 08:11:57 xeon-e3 kernel: [159474.037390] Read-error on swap-device (259:0:17597808)
kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855526] Read-error on swap-device (259:0:11355648)
kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855530] Read-error on swap-device (259:0:11355656)
kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87939.855467] Read-error on swap-device (259:0:16180824)
kern.log.1:Jan  8 08:24:07 xeon-e3 kernel: [63670.777981] Read-error on swap-device (259:0:32690768)
kern.log.1:Jan  9 09:25:02 xeon-e3 kernel: [153720.919325] Read-error on swap-device (259:0:220488)
kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.957675] Read-error on swap-device (259:0:24476232)
kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.962673] Read-error on swap-device (259:0:33292816)

The swap device was being added via /etc/fstab by UUID. 

I gave up and went back to spinning rust for swap device for stabilty.

Device partitions are:

Disk /dev/nvme0n1: 781422768 sectors, 372.6 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): 304117A4-18EF-4B51-92F4-8015758B5CB0
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 781422734
Partitions will be aligned on 8-sector boundaries
Total free space is 0 sectors (0 bytes)

Number  Start (sector)    End (sector)  Size       Code  Name
   1              34            2047   1007.0 KiB  EF02  BIOS boot partition
   2            2048        33556479   16.0 GiB    8200  Linux swap
   3        33556480       781422734   356.6 GiB   8300  Linux filesystem
