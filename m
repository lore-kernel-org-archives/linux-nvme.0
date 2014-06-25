From: azher@hep.caltech.edu (Azher Mughal)
Date: Wed, 25 Jun 2014 07:21:25 -0700
Subject: Kernel 3.10.0  with nvme-compatibility driver
Message-ID: <53AADAE5.4050401@hep.caltech.edu>

Hi All,

I just started playing with Intel NVME PCIe cards and trying to optimize
system performance. I am using RHEL7, kernel 3.10 and the
nvme-compatibility drivers due to the fact that Mellanox software
distribution don't support kernel 3.15 at the moment. Server has dual
E5-2690 v2 processors and 64GB RAM. The aim is to design a server which
can match WAN transfer at 100Gbps by writing on the nvme drives.

The maximum performance I have seen is about 1.4GB/sec per drive running
in parallel over 6 drives. I plan to add a total of 10 drives. In these
tests, dd is used  "dd if=/dev/zero of=/nvme$i/$file.dump count=700000
bs=4096k". Graphs in below URLS are created from output by dstat:

http://www.ultralight.org/~azher/nvme/dd-bs4k.png
http://www.ultralight.org/~azher/nvme/cpu-graph.PNG

Disk Formatting scripts:
http://www.ultralight.org/~azher/nvme/nvme-format.txt
http://www.ultralight.org/~azher/nvme/nvme.txt

Since the idle CPU is already at 40%, so I wonder what will happen when
adding 4 more drives. So my questions are:

1. How to force drivers and kernel to keep nvme driver on just one
socket and let the kernel use the other processor for WAN transfer using
Mellanox and TCP overheads ?
2. Kernel optimizations to reduce the nvme CPU usage ? With current
driver, I cannot change scheduler and nr_requests.
3. Data write per drive is not steady, what could be the reason ?

Any suggestions / help would be appreciated.

Thanks
-Azher
