From: shhuiw@foxmail.com (=?ISO-8859-1?B?V2FuZyBTaGVuZy1IdWk=?=)
Date: Tue, 31 May 2016 16:43:34 +0800
Subject: why use alloc_workqueue instead of create_singlethread_workqueue to
 create nvme_workq
Message-ID: <tencent_4323E1CE03D759181B6B4507@qq.com>

Keith,

Sorry to trouble you!

Recently I noticed warning on NVME probe if CMA is enabled on my SoC platform
(ZONE_DMA, ZONE_DMA32 and CMA enabled in the config file):
--------------------------------------------------------------------------------
WARNING: CPU: 0 PID: 6 at linux/kernel/workqueue.c:2448 check_flush_dependency+0xb4/0x10c
[    0.154083] [<fffffc00080d6de0>] check_flush_dependency+0xb4/0x10c
[    0.154088] [<fffffc00080d8e80>] flush_work+0x54/0x140
[    0.154092] [<fffffc0008166a0c>] lru_add_drain_all+0x138/0x188
[    0.154097] [<fffffc00081ab2dc>] migrate_prep+0xc/0x18
[    0.154101] [<fffffc0008160e88>] alloc_contig_range+0xf4/0x350
[    0.154105] [<fffffc00081bcef8>] cma_alloc+0xec/0x1e4
[    0.154110] [<fffffc0008446ad0>] dma_alloc_from_contiguous+0x38/0x40
[    0.154114] [<fffffc00080a093c>] __dma_alloc+0x74/0x25c
[    0.154119] [<fffffc00084828d8>] nvme_alloc_queue+0xcc/0x36c
[    0.154123] [<fffffc0008484b2c>] nvme_reset_work+0x5c4/0xda8
[    0.154128] [<fffffc00080d9528>] process_one_work+0x128/0x2ec
[    0.154132] [<fffffc00080d9744>] worker_thread+0x58/0x434
[    0.154136] [<fffffc00080df0ec>] kthread+0xd4/0xe8
[    0.154141] [<fffffc0008093ac0>] ret_from_fork+0x10/0x50


I tried on x86_64 KVM guest, and can get the similar warning with CMA and DMA enabled.


I searched the log and found 92f7a1624:
---------------------------------------------------------------------------------
commit 92f7a1624bbc2361b96db81de89aee1baae40da9
Author: Keith Busch <keith.busch at intel.com>
Date:   Fri Oct 23 11:42:02 2015 -0600

    NVMe: Use unbounded work queue for all work

    Removes all usage of the global work queue so work can't be
    scheduled on two different work queues, and removes nvme's work queue
    singlethreadedness so controllers can be driven in parallel.

...
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fac1de8..a909a8b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
...
@@ -2451,7 +2451,7 @@ static int __init nvme_init(void)

        init_waitqueue_head(&nvme_kthread_wait);

-       nvme_workq = create_singlethread_workqueue("nvme");
+       nvme_workq = alloc_workqueue("nvme", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
        if (!nvme_workq)
                return -ENOMEM;



But the log only explained why changed to workqueue instead of schedule_work, 
no comments why use alloc_workqueue instead of create_singlethread_workqueue,
though 
       "The original create_*workqueue() functions are deprecated and scheduled for removal." 
(Documentation/workqueue.txt; https://patchwork.ozlabs.org/patch/575570/). 

The key point is "__WQ_LEGACY" was dropped. 
If I change to use "nvme_workq = create_singlethread_workqueue("nvme");",  then no
warning on NVME probe in my case.

My question is, why you decide drop the flag "__WQ_LEGACY" for nvme_workq?


------------------
Regards,
Wang Sheng-Hui
