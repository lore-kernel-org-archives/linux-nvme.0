From: nvme@elfenteich.de (Carina Willbold)
Date: Sun, 15 May 2016 22:19:13 +0200
Subject: Accessing the NVMe flash drive of the April 2016 MacBook 12" (A1534)
Message-ID: <10c3272709f4fc720d862c81da85e6e9@speicherleck.de>

Dear NVMe hackers,

I'm trying to access the built-in flash drive of the new April 2016 
MacBook 12" (A1534). Based on suggestions for older MacBooks on this 
list, I loaded the module nvme, and, since the flash drive reports an 
incorrect PCI device class, manually bound it with:

     echo 106b 2003 > /sys/bus/pci/drivers/nvme/new_id

The dmesg output is non-informative, it just reports that the probe 
failed. The flash drive reports under lspci -nn as:

     01:00.0 Mass storage controller [0180]: Apple Inc. Device 
[106b:2003] (rev 11)

Note that this is different from previous versions of the MacBook 
(where the PCI ID was 106b:2001). The flash drive is detected from the 
Grub shell and works just fine from Mac OS X.

I know a bit of C, but have zero experience debugging or programming 
drivers. I'm willing to learn! What should I try next?

Thank you for any advice :-).

LLAP
Carina

PS: I also posted this at 
http://unix.stackexchange.com/questions/283154/accessing-the-nvme-flash-drive-of-the-april-2016-macbook-12-a1534. 
However I believe that this list is better suited.
