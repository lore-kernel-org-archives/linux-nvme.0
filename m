From: pgadmin@pse-consulting.de (Andreas Pflug)
Date: Mon, 10 Jul 2017 20:03:16 +0200
Subject: kernel BUG at nvme/host/pci.c
Message-ID: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>

I'm running a patched (see below) debian 4.9.30 kernel with xen4.8.1 on 
Debian9. Starting a specific virtual machine, very soon the kernel will emit

     kernel BUG at /usr/src/kernel/linux-4.9.30/drivers/nvme/host/pci.c:495!

via netconsole to my logging host, and become unstable until hard reset. 
Hardware is dual E5-2620v4 on Supermicro 10DRI-T with two SAMSUNG 
MZQLW960HMJP-00003 NVME disks (mdadm RAID-1) backing the vhds (os on 
separate SSD).

The bug was reported to debian as https://bugs.debian.org/866511 . 
According to Ben Hutchings' advice, I patched the standard kernel with 
0001-swiotlb-ensure-that-page-sized-mappings-are-page-ali.patch since 
its description sounded promising, but the bug remains.

Log is attached, cut after 460 lines: the last trace on CPU15 is 
repeated all over again, eventually leading to "Fixing recursive fault 
but reboot is needed!"

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xen2-kernel.log
Type: text/x-log
Size: 17073 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170710/e8cb46ce/attachment.bin>
