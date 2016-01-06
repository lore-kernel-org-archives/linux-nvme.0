From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 19:31:28 +0000
Subject: Maximum NVMe IO command size > 1MB?
In-Reply-To: <cc642ee3fec8476b9034e1ee397e8f42@SC-EXCH01.marvell.com>
References: <cc642ee3fec8476b9034e1ee397e8f42@SC-EXCH01.marvell.com>
Message-ID: <20160106193127.GA20732@localhost.localdomain>

On Wed, Jan 06, 2016@07:23:53PM +0000, Xuehua Chen wrote:
> It seems to me kernel 4.3 supports NVMe IO command size > 512k after the following is added. 
> 
> blk_queue_max_segments(ns->queue,
>        ((dev->max_hw_sectors << 9) / dev->page_size) + 1);
> 
> If I run the fllowing, 
> fio --name=iotest --filename=/dev/nvme0n1 --iodepth=1 --ioengine=libaio --direct=1 --size=1M --bs=1M --rw=read
> 
> I can see one read with data transfer size 1MB is sent to device. 
> 
> But if I increase the bs to 2M as below, I still see two 1MB commands are sent out instead of one 2MB read command
> fio --name=iotest --filename=/dev/nvme0n1 --iodepth=1 --ioengine=libaio --direct=1 --size=2M --bs=2M --rw=read
> 
> Is there any other settings in kernel that make it split a 2M command into two 1M commands? 

Is the device actually capable of 2MB transfers? You can confirm with:

  # cat /sys/block/nvme0n1/queue/max_hw_sectors_kb
