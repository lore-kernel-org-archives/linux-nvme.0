From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 May 2016 10:53:06 -0400
Subject: why use alloc_workqueue instead of create_singlethread_workqueue
 to create nvme_workq
In-Reply-To: <tencent_4323E1CE03D759181B6B4507@qq.com>
References: <tencent_4323E1CE03D759181B6B4507@qq.com>
Message-ID: <20160531145306.GB24107@localhost.localdomain>

On Tue, May 31, 2016@04:43:34PM +0800, Wang Sheng-Hui wrote:
> Recently I noticed warning on NVME probe if CMA is enabled on my SoC platform
> (ZONE_DMA, ZONE_DMA32 and CMA enabled in the config file):
> --------------------------------------------------------------------------------
> WARNING: CPU: 0 PID: 6 at linux/kernel/workqueue.c:2448 check_flush_dependency+0xb4/0x10c
> [    0.154083] [<fffffc00080d6de0>] check_flush_dependency+0xb4/0x10c
> [    0.154088] [<fffffc00080d8e80>] flush_work+0x54/0x140
> [    0.154092] [<fffffc0008166a0c>] lru_add_drain_all+0x138/0x188
> [    0.154097] [<fffffc00081ab2dc>] migrate_prep+0xc/0x18
> [    0.154101] [<fffffc0008160e88>] alloc_contig_range+0xf4/0x350
> [    0.154105] [<fffffc00081bcef8>] cma_alloc+0xec/0x1e4
> [    0.154110] [<fffffc0008446ad0>] dma_alloc_from_contiguous+0x38/0x40
> [    0.154114] [<fffffc00080a093c>] __dma_alloc+0x74/0x25c
> [    0.154119] [<fffffc00084828d8>] nvme_alloc_queue+0xcc/0x36c
> [    0.154123] [<fffffc0008484b2c>] nvme_reset_work+0x5c4/0xda8
> [    0.154128] [<fffffc00080d9528>] process_one_work+0x128/0x2ec
> [    0.154132] [<fffffc00080d9744>] worker_thread+0x58/0x434
> [    0.154136] [<fffffc00080df0ec>] kthread+0xd4/0xe8
> [    0.154141] [<fffffc0008093ac0>] ret_from_fork+0x10/0x50

The lru drain work is scheduled on the system work queue, which is not
used for memory reclaim. But this work is used for swap, so maybe it
should be scheduled on a such a work queue, and this warning would go
away. Unless there's a reason not to have a system memory reclaim work
queue, I'll look into that.

> But the log only explained why changed to workqueue instead of schedule_work, 
> no comments why use alloc_workqueue instead of create_singlethread_workqueue,
> though 

We removed single threaded work queues so multiple controllers can be
probed in parallel.

>        "The original create_*workqueue() functions are deprecated and scheduled for removal." 
> (Documentation/workqueue.txt; https://patchwork.ozlabs.org/patch/575570/). 
> 
> The key point is "__WQ_LEGACY" was dropped. 
> If I change to use "nvme_workq = create_singlethread_workqueue("nvme");",  then no
> warning on NVME probe in my case.
> 
> My question is, why you decide drop the flag "__WQ_LEGACY" for nvme_workq?

I didn't decide to drop this. The flag is used for deprecated usage,
but this is new usage.

I think the real issue is nvme uses a WQ_MEM_RECLAIM work queue but swap
does not. One of these probably needs to change.
