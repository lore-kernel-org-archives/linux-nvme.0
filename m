From: xuehua@marvell.com (Xuehua Chen)
Date: Sun, 10 Jan 2016 22:16:53 +0000
Subject: Maximum NVMe IO command size > 1MB?
In-Reply-To: <20160106225457.GA23888@localhost.localdomain>
References: <cc642ee3fec8476b9034e1ee397e8f42@SC-EXCH01.marvell.com>
 <20160106193127.GA20732@localhost.localdomain>
 <680a6c16f5464419b7e1974d04026951@SC-EXCH01.marvell.com>
 <ba6abd8303c84156b1c530dcbf101f40@SC-EXCH01.marvell.com>
 <20160106225457.GA23888@localhost.localdomain>
Message-ID: <a03e9ceb15fa479fbbbe272feb84df26@SC-EXCH01.marvell.com>

Yes, dio_new_bio() caused the splitting.

Tried raising BIO_MAX_PAGES to 512 and run the command below again.
fio --name=iotest --filename=/dev/nvme0n1 --iodepth=1 --ioengine=libaio --direct=1 --size=2M --bs=2M --rw=read

It is found one 1280K command and one 768K command are sent instead of two 1M commands. It seems new BIO_MAX_PAGES
takes effect and there is another factor cause the command to split. The splitting seems to be caused by the value of 
/sys/block/nvme0n1/queue/max_sectors_kb, which is 1280. After changing its value to 2048, one 2M command is sent. 
Also tried increasing iodepth to 512 and size to 1G and run multiple times, it runs well.

Below is the description of max_sectors_kb in queue-sysfs.txt

max_sectors_kb (RW)
-------------------
This is the maximum number of kilobytes that the block layer will allow
for a filesystem request. Must be smaller than or equal to the maximum
size allowed by the hardware.

It seems that BIO_MAX_PAGES and max_sectors_kb are two more factors that limit the maximum size of a transfer. 

One thing that caught my attention is max_sectors_kb is determined by BLk_DEF_MAX_SECTORS, which is defined as
2560 in blkdev.h. It seems that it does not show accurately the maximum size of a transfer, 1028KB for kernel 
4.3 due to the current value of BIO_MAX_PAGES, 256. 

Based on the findings, I would propose the below changes. 

1. Change BLK_DEF_MAX_SECTORS from 2560 to BIO_MAX_SECTORS(2048). 
2. Previously users can change max_sectors_kb to any value which is smaller than or equal to that of max_hw_sectors_kb.
Change the behavior so that users cannot change it to any value which is bigger than the minimum limit determined by both 
max_hw_sectors_kb and BIO_MAX_SECTORS.
3. Update queue-sysfs.txt for item max_sectors_kb to also mention the limit caused by BIO_MAX_SECTORS.
4. Possibly add an configuration option for kernel to support BIO size of 2MB or more. 

Any comments?

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, January 06, 2016 2:55 PM
To: Xuehua Chen
Cc: linux-nvme at lists.infradead.org
Subject: Re: Maximum NVMe IO command size > 1MB?

On Wed, Jan 06, 2016@09:56:24PM +0000, Xuehua Chen wrote:
> Hi, Keith,
> 
> I wonder whether this could be caused by BIO_MAX_PAGES defined as 256, which means 1MB at most.
> What do you think?

I think you got it. You're running O_DIRECT, and fs/direct-io.c,
dio_new_bio() allocates up to BIO_MAX_PAGES.

I can't tell where the value for came from (looks like it was there from the very first git commit), but maybe you can propose raising it if you set BIO_MAX_PAGES higher without issue.
