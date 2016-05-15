From: nvme@elfenteich.de (Carina Willbold)
Date: Mon, 16 May 2016 01:48:00 +0200
Subject: Accessing the NVMe flash drive of the April 2016 MacBook 12"
 (A1534)
In-Reply-To: <10c3272709f4fc720d862c81da85e6e9@speicherleck.de>
References: <10c3272709f4fc720d862c81da85e6e9@speicherleck.de>
Message-ID: <eaaba356177409f3a40afc33d938d42c@speicherleck.de>

Dear NVMe hackers,

Am 2016-05-15 22:19, schrieb Carina Willbold:
> I'm trying to access the built-in flash drive of the new April 2016
> MacBook 12" (A1534).

please forgive me for commiting a basic newbie mistake: I went with the
default Arch Linux kernel (4.5.1) instead of going for the newest one.
I'm sorry for the noise.

With 4.6.0-rc7, after binding using

     echo 106b 2003 > /sys/bus/pci/drivers/nvme/new_id

the flash disk *is* recognized:

     [  126.904767] nvme nvme0: pci function 0000:01:00.0
     [  127.117492]  nvme0n1: p1 p2 p3 p4

However actually trying to access one of the partitions (for instance, 
trying
to mount them or executing head -c 20 /dev/nvme0n1p1) results in 
timeouts:

     [  187.354937] nvme nvme0: I/O 0 QID 0 timeout, reset controller
     [  187.365069] nvme nvme0: I/O 0 QID 1 timeout, aborting
     [  200.322625] nvme nvme0: completing aborted command with status: 
0000
     [  200.322634] nvme nvme0: completing aborted command with status: 
0000
     [  269.366379] nvme nvme0: I/O 1 QID 1 timeout, reset controller
     [  308.027258] nvme nvme0: completing aborted command with status: 
0000
     [  308.027295] nvme nvme0: completing aborted command with status: 
0000
     [  308.027314] nvme nvme0: completing aborted command with status: 
0000

At one point printing the first few bytes of /dev/nvme0n1p1 actually 
succeeded
(giving the expected EFI/FAT32 headers).

I'm happy to provide any additional information or start hacking the 
driver code
(if given a starting point).

LLAP,
Carina
