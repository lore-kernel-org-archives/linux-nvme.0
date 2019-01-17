From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Jan 2019 17:16:49 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <1547579226.83374.114.camel@acm.org>
References: <1547579226.83374.114.camel@acm.org>
Message-ID: <6c18d8f8-949f-9502-566a-643d384e9113@grimberg.me>


On 1/15/19 11:07 AM, Bart Van Assche wrote:
> Hello,
> 
> With Linus' kernel v5.0-rc2 the blktests nvmeof-mp tests trigger the
> complaint shown below. Is this a known issue?

Seems like ns remove is racing with ns revalidate again..

Wasn't this related to: eb4c2382272a ("srcu: Lock srcu_data structure in 
srcu_gp_start()") ?


> 
> Thanks,
> 
> Bart.
> 
> ==================================================================
> nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: cm_id= 0000000090ef5516 queue->state= 1
> BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x209/0x290
> Read of size 8 at addr ffff88810eb9f6f0 by task kworker/4:22/17434
> 
> CPU: 4 PID: 17434 Comm: kworker/4:22 Not tainted 5.0.0-rc2-dbg+ #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Workqueue: rcu_gp srcu_invoke_callbacks
> Call Trace:
>   dump_stack+0x86/0xca
>   print_address_description+0x71/0x239
>   ? srcu_invoke_callbacks+0x209/0x290
>   kasan_report.cold.3+0x1b/0x3e
>   ? srcu_invoke_callbacks+0x209/0x290
>   __asan_load8+0x54/0x90
>   srcu_invoke_callbacks+0x209/0x290
>   ? check_init_srcu_struct.part.8+0x60/0x60
>   process_one_work+0x4f4/0xa30
>   ? pwq_dec_nr_in_flight+0x130/0x130
>   worker_thread+0x67/0x5b0
>   kthread+0x1cf/0x1f0
>   ? process_one_work+0xa30/0xa30
>   ? kthread_create_on_node+0xa0/0xa0
>   ret_from_fork+0x24/0x30
> 
> Allocated by task 55:
>   save_stack+0x43/0xd0
>   __kasan_kmalloc.constprop.9+0xd0/0xe0
>   kasan_kmalloc+0xe/0x10
>   kmem_cache_alloc_trace+0x14c/0x340
>   nvme_validate_ns+0xada/0x1170
>   nvme_scan_work+0x299/0x4c8
>   process_one_work+0x4f4/0xa30
>   worker_thread+0x67/0x5b0
>   kthread+0x1cf/0x1f0
>   ret_from_fork+0x24/0x30
> 
> Freed by task 3432:
>   save_stack+0x43/0xd0
>   __kasan_slab_free+0x13e/0x190
>   kasan_slab_free+0x13/0x20
>   kfree+0x103/0x320
>   nvme_free_ns+0x198/0x1a0
>   nvme_ns_remove+0x1c5/0x240
>   nvme_remove_namespaces+0x1b3/0x210
>   nvme_delete_ctrl_work+0x7d/0xe0
>   process_one_work+0x4f4/0xa30
>   worker_thread+0x367/0x5b0
>   kthread+0x1cf/0x1f0
>   ret_from_fork+0x24/0x30
> 
> nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 3
> The buggy address belongs to the object at ffff88810eb9f500
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 496 bytes inside of
>   1024-byte region [ffff88810eb9f500, ffff88810eb9f900)
> nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: disconnected (10): status 0 id 00000000bbf5c2b8
> The buggy address belongs to the page:
> page:ffffea00043ae600 count:1 mapcount:0 mapping:ffff88811b002a00 index:0xffff88810eb9f500 compound_mapcount: 0
> nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma: cm_id= 00000000bbf5c2b8 queue->state= 1
> flags: 0x2fff000000010200(slab|head)
> nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 4
> raw: 2fff000000010200 ffffea000454d000 0000000300000003 ffff88811b002a00
> nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: disconnected (10): status 0 id 000000008a4de807
> raw: ffff88810eb9f500 00000000801c0013 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff88810eb9f580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88810eb9f600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff88810eb9f680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                               ^
>   ffff88810eb9f700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88810eb9f780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
