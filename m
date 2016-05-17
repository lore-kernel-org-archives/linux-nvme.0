From: mlin@kernel.org (Ming Lin)
Date: Tue, 17 May 2016 14:09:34 -0700
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <20160517210706.GB19325@localhost.localdomain>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
 <1463295520.5272.4.camel@kernel.org>
 <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
 <20160517150511.GB14260@localhost.localdomain>
 <20160517152359.GC14260@localhost.localdomain>
 <20160517153003.GA18529@localhost.localdomain>
 <CAF1ivSaEg2wiH3hwpRmeK7ua69ERT5MP8MqZyuc6Dtb2fes6gg@mail.gmail.com>
 <20160517210706.GB19325@localhost.localdomain>
Message-ID: <CAF1ivSbi8rXgsM885w0EMyzMnDuiGOUUfu3o+RKbz1KG2jJW6Q@mail.gmail.com>

On Tue, May 17, 2016@2:07 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, May 17, 2016@01:48:18PM -0700, Ming Lin wrote:
>> I applied below changes and it seems work.
>
> Great, thanks. I was getting good results with this as well.

Thanks for the fix. Could you send the patch formally?

>
>> But here is a crash when I do stress reset test with live IO.
>>
>> while [ 1 ] ; do
>>         echo > /sys/class/nvme/nvme0/reset_controller
>> done
>>
>> I think this crash is not related to your patch. Because I can
>> reproduce it without your patch.
>
> Bummer. Is your controller using sparse namespaces? The kernel message
> before the bug appears to indicate that.

No. Only 1 namespace.

Thanks.

>
>
>> [   44.985454] block (null): nvme_revalidate_disk: Identify failure
>> [   45.089224] BUG: unable to handle kernel paging request at 000000006fc81ab0
>> [   45.096949] IP: [<ffffffff811a0baf>] kmem_cache_alloc+0x7f/0x170
>> [   45.103705] PGD 0
>> [   45.106470] Oops: 0000 [#1] PREEMPT SMP
>> [   45.229716] CPU: 0 PID: 72 Comm: kworker/0:1 Tainted: GOE   4.6.0-rc3+ #197
>> [   45.238557] Hardware name: Dell Inc. OptiPlex 7010/0773VG, BIOS A12 01/10/2013
>> [   45.246709] Workqueue: events nvme_scan_work [nvme_core]
>> [   45.252977] task: ffff8800da071640 ti: ffff8800da3c4000 task.ti: ffff8800da3c4000
>> [   45.261403] RIP: 0010:[<ffffffff811a0baf>]  [<ffffffff811a0baf>] kmem_cache_alloc+0x7f/0x170
>> [   45.270804] RSP: 0018:ffff8800da3c7b50  EFLAGS: 00010286
>> [   45.277075] RAX: 0000000000000000 RBX: 00000000024000c0 RCX: 0000000000f5cc00
>> [   45.285167] RDX: 0000000000f5cb00 RSI: 0000000000f5cb00 RDI: 0000000000000246
>> [   45.293252] RBP: ffff8800da3c7b70 R08: 00000000000199f0 R09: 0000000000000000
>> [   45.301342] R10: 0000000000000001 R11: 0000000000000000 R12: 000000006fc81ab0
>> [   45.309441] R13: ffff88011b402f00 R14: 00000000024000c0 R15: ffff88011b402f00
>> [   45.317554] FS:  0000000000000000(0000) GS:ffff880120200000(0000) knlGS:0000000000000000
>> [   45.326624] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   45.333372] CR2: 000000006fc81ab0 CR3: 0000000001c06000 CR4: 00000000001406f0
>> [   45.341512] Stack:
>> [   45.344548]  00000000024000c0 0000000000000002 ffffffff81147810 ffff8800d043d600
>> [   45.353020]  ffff8800da3c7b80 ffffffff81147820 ffff8800da3c7bc8 ffffffff81147d9f
>> [   45.361503]  ffffffff00000001 ffffffff81147830 ffff88011b403400 0000000000000002
>> [   45.369979] Call Trace:
>> [   45.373455]  [<ffffffff81147810>] ? mempool_kfree+0x10/0x10
>> [   45.380043]  [<ffffffff81147820>] mempool_alloc_slab+0x10/0x20
>> [   45.386888]  [<ffffffff81147d9f>] mempool_create_node+0xcf/0x130
>> [   45.393896]  [<ffffffff81147830>] ? mempool_alloc_slab+0x20/0x20
>> [   45.400910]  [<ffffffff81147e15>] mempool_create+0x15/0x20
>> [   45.407453]  [<ffffffff8134073e>] __bioset_create+0x1ee/0x2d0
>> [   45.414171]  [<ffffffff8137bec5>] ? ida_simple_get+0x85/0xe0
>> [   45.420799]  [<ffffffff8134082e>] bioset_create+0xe/0x10
>> [   45.427077]  [<ffffffff81344d0f>] blk_alloc_queue_node+0x5f/0x2e0
>> [   45.434124]  [<ffffffff8135390b>] blk_mq_init_queue+0x1b/0x60
>> [   45.440830]  [<ffffffffc081d272>] nvme_validate_ns+0xb2/0x290 [nvme_core]
>> [   45.448570]  [<ffffffffc081d665>] nvme_scan_work+0x215/0x330 [nvme_core]
>> [   45.456215]  [<ffffffff81088ce3>] process_one_work+0x1a3/0x430
>> [   45.462994]  [<ffffffff81088c87>] ? process_one_work+0x147/0x430
>> [   45.469947]  [<ffffffff81089096>] worker_thread+0x126/0x4a0
>> [   45.476468]  [<ffffffff8176871b>] ? __schedule+0x2fb/0x8d0
>> [   45.482902]  [<ffffffff81088f70>] ? process_one_work+0x430/0x430
>> [   45.489855]  [<ffffffff8108f529>] kthread+0xf9/0x110
>> [   45.495770]  [<ffffffff8176e912>] ret_from_fork+0x22/0x50
>> [   45.502109]  [<ffffffff8108f430>] ? kthread_create_on_node+0x230/0x230
