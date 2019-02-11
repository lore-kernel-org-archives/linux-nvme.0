From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 11 Feb 2019 09:24:51 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <6c18d8f8-949f-9502-566a-643d384e9113@grimberg.me>
References: <1547579226.83374.114.camel@acm.org>
 <6c18d8f8-949f-9502-566a-643d384e9113@grimberg.me>
Message-ID: <1549905891.19311.5.camel@acm.org>

On Wed, 2019-01-16@17:16 -0800, Sagi Grimberg wrote:
> On 1/15/19 11:07 AM, Bart Van Assche wrote:
> > Hello,
> > 
> > With Linus' kernel v5.0-rc2 the blktests nvmeof-mp tests trigger the
> > complaint shown below. Is this a known issue?
> 
> Seems like ns remove is racing with ns revalidate again..
> 
> Wasn't this related to: eb4c2382272a ("srcu: Lock srcu_data structure in 
> srcu_gp_start()") ?

(+Paul)

I'm not sure. Paul, are you perhaps aware of any open issues in the RCU
infrastructure? If I run the following test:

git clone https://github.com/osandov/blktests.git
cd blktests
./check -q nvmeof-mp

then the following appears on the console:

BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x209/0x290
Read of size 8 at addr ffff8881126b6df0 by task kworker/2:94/26747
CPU: 2 PID: 26747 Comm: kworker/2:94 Not tainted 5.0.0-rc5-dbg+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: rcu_gp srcu_invoke_callbacks
Call Trace:
 dump_stack+0x86/0xca
 print_address_description+0x71/0x239
 kasan_report.cold.3+0x1b/0x3e
 __asan_load8+0x54/0x90
 srcu_invoke_callbacks+0x209/0x290
 process_one_work+0x4f1/0xa40
 worker_thread+0x67/0x5b0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

Allocated by task 955:
 save_stack+0x43/0xd0
 __kasan_kmalloc.constprop.9+0xcb/0xd0
 kasan_kmalloc+0x9/0x10
 kmem_cache_alloc_trace+0x14c/0x340
 nvme_validate_ns+0xada/0x1170
 nvme_scan_work+0x299/0x4c8
 process_one_work+0x4f1/0xa40
 worker_thread+0x67/0x5b0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

Freed by task 55:
 save_stack+0x43/0xd0
 __kasan_slab_free+0x139/0x190
 kasan_slab_free+0xe/0x10
 kfree+0x103/0x320
 nvme_free_ns+0x198/0x1a0
 nvme_ns_remove+0x1c5/0x240
 nvme_remove_namespaces+0x1b3/0x210
 nvme_delete_ctrl_work+0x7d/0xe0
 process_one_work+0x4f1/0xa40
 worker_thread+0x367/0x5b0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

The buggy address belongs to the object at ffff8881126b6c00
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 496 bytes inside of
 1024-byte region [ffff8881126b6c00, ffff8881126b7000)
The buggy address belongs to the page:
page:ffffea000449ac00 count:1 mapcount:0 mapping:ffff88811b002a00 index:0xffff8881126b1f80 compound_mapcount: 0
flags: 0x2fff000000010200(slab|head)
raw: 2fff000000010200 ffffea00042bcc08 ffffea000457b808 ffff88811b002a00
raw: ffff8881126b1f80 00000000001c0011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881126b6c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881126b6d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881126b6d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff8881126b6e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881126b6e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
