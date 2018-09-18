From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 18 Sep 2018 14:16:48 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
Message-ID: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>

Hello,

If I run the nvmeof-mp tests from https://github.com/bvanassche/blktests 
against kernel v4.19-rc4 then a KASAN complaint appears. This complaint 
does not appear when I run these tests against kernel v4.18. Could this 
be a regression?

Thanks,

Bart.

BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290
Read of size 8 at addr ffff880074250f70 by task kworker/0:3/26033

CPU: 0 PID: 26033 Comm: kworker/0:3 Not tainted 4.19.0-rc4-dbg+ #1
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Workqueue: rcu_gp srcu_invoke_callbacks
Call Trace:
dump_stack+0xa4/0xf5
print_address_description+0x78/0x290
kasan_report+0x241/0x360
__asan_load8+0x54/0x90
srcu_invoke_callbacks+0x207/0x290
process_one_work+0x4ae/0xa20
worker_thread+0x63/0x5a0
kthread+0x1cf/0x1f0
ret_from_fork+0x24/0x30

Allocated by task 24735:
save_stack+0x43/0xd0
kasan_kmalloc+0xad/0xe0
kmem_cache_alloc_trace+0x13d/0x300
nvme_validate_ns+0x8e9/0x1020 [nvme_core]
nvme_scan_work+0x3be/0x4a0 [nvme_core]
process_one_work+0x4ae/0xa20
worker_thread+0x63/0x5a0
kthread+0x1cf/0x1f0
ret_from_fork+0x24/0x30

Freed by task 17790:
save_stack+0x43/0xd0
__kasan_slab_free+0x135/0x190
kasan_slab_free+0xe/0x10
kfree+0x105/0x2e0
nvme_free_ns+0x160/0x1a0 [nvme_core]
nvme_ns_remove+0x1ba/0x250 [nvme_core]
nvme_remove_invalid_namespaces+0x1d9/0x220 [nvme_core]
nvme_scan_work+0x43b/0x4a0 [nvme_core]
process_one_work+0x4ae/0xa20
worker_thread+0x63/0x5a0
kthread+0x1cf/0x1f0
ret_from_fork+0x24/0x30

The buggy address belongs to the object at ffff880074250d80
which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 496 bytes inside of
1024-byte region [ffff880074250d80, ffff880074251180)
The buggy address belongs to the page:
page:ffffea0001d09400 count:1 mapcount:0 mapping:ffff88011bf8ea00 
index:0x0 compound_mapcount: 0
flags: 0x4000000000008100(slab|head)
raw: 4000000000008100 ffffea0003587a00 0000000200000002 ffff88011bf8ea00
raw: 0000000000000000 00000000001c001c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff880074250e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff880074250e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff880074250f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
ffff880074250f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff880074251000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
