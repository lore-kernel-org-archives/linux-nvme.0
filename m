From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 7 Dec 2018 09:57:34 +0800
Subject: [PATCH] nvme: limit max io queues as 1 in case of kdump kernel
In-Reply-To: <e323db5c-d4ba-bc3c-ad09-8f9a9764f370@kernel.dk>
References: <20181206113807.15238-1-ming.lei@redhat.com>
 <7d679d92-b732-2abc-80e3-68c4460af5dc@kernel.dk>
 <20181207011300.GA20828@ming.t460p>
 <a810be22-714a-8aec-2e51-7354e0d916c1@kernel.dk>
 <20181207013708.GB20828@ming.t460p>
 <e323db5c-d4ba-bc3c-ad09-8f9a9764f370@kernel.dk>
Message-ID: <20181207015733.GC20828@ming.t460p>

On Thu, Dec 06, 2018@06:39:44PM -0700, Jens Axboe wrote:
> On 12/6/18 6:37 PM, Ming Lei wrote:
> > On Thu, Dec 06, 2018@06:14:01PM -0700, Jens Axboe wrote:
> >> On 12/6/18 6:13 PM, Ming Lei wrote:
> >>> On Thu, Dec 06, 2018@08:31:00AM -0700, Jens Axboe wrote:
> >>>> On 12/6/18 4:38 AM, Ming Lei wrote:
> >>>>> NVMe PCI builds queue mapping before allocating tagset, in which
> >>>>> set->nr_hw_queues is set as 1 in case of kdump kernel, so wrong
> >>>>> queue mapping can be setup, and kernel panic[1] is observed during
> >>>>> booting.
> >>>>>
> >>>>> This patch fixes the issue by setting max io queues as 1 under this
> >>>>> situation.
> >>>>>
> >>>>> [1] kernel panic log
> >>>>> [    4.438371] nvme nvme0: 16/0/0 default/read/poll queues
> >>>>> [    4.443277] BUG: unable to handle kernel NULL pointer dereference at 0000000000000098
> >>>>> [    4.444681] PGD 0 P4D 0
> >>>>> [    4.445367] Oops: 0000 [#1] SMP NOPTI
> >>>>> [    4.446342] CPU: 3 PID: 201 Comm: kworker/u33:10 Not tainted 4.20.0-rc5-00664-g5eb02f7ee1eb-dirty #459
> >>>>> [    4.447630] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> >>>>> [    4.448689] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> >>>>> [    4.449368] RIP: 0010:blk_mq_map_swqueue+0xfb/0x222
> >>>>> [    4.450596] Code: 04 f5 20 28 ef 81 48 89 c6 39 55 30 76 93 89 d0 48 c1 e0 04 48 03 83 f8 05 00 00 48 8b 00 42 8b 3c 28 48 8b 43 58 48 8b 04 f8 <48> 8b b8 98 00 00 00 4c 0f a3 37 72 42 f0 4c 0f ab 37 66 8b b8 f6
> >>>>> [    4.453132] RSP: 0018:ffffc900023b3cd8 EFLAGS: 00010286
> >>>>> [    4.454061] RAX: 0000000000000000 RBX: ffff888174448000 RCX: 0000000000000001
> >>>>> [    4.456480] RDX: 0000000000000001 RSI: ffffe8feffc506c0 RDI: 0000000000000001
> >>>>> [    4.458750] RBP: ffff88810722d008 R08: ffff88817647a880 R09: 0000000000000002
> >>>>> [    4.464580] R10: ffffc900023b3c10 R11: 0000000000000004 R12: ffff888174448538
> >>>>> [    4.467803] R13: 0000000000000004 R14: 0000000000000001 R15: 0000000000000001
> >>>>> [    4.469220] FS:  0000000000000000(0000) GS:ffff88817bac0000(0000) knlGS:0000000000000000
> >>>>> [    4.471554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> [    4.472464] CR2: 0000000000000098 CR3: 0000000174e4e001 CR4: 0000000000760ee0
> >>>>> [    4.474264] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>> [    4.476007] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>> [    4.477061] PKRU: 55555554
> >>>>> [    4.477464] Call Trace:
> >>>>> [    4.478731]  blk_mq_init_allocated_queue+0x36a/0x3ad
> >>>>> [    4.479595]  blk_mq_init_queue+0x32/0x4e
> >>>>> [    4.480178]  nvme_validate_ns+0x98/0x623 [nvme_core]
> >>>>> [    4.480963]  ? nvme_submit_sync_cmd+0x1b/0x20 [nvme_core]
> >>>>> [    4.481685]  ? nvme_identify_ctrl.isra.8+0x70/0xa0 [nvme_core]
> >>>>> [    4.482601]  nvme_scan_work+0x23a/0x29b [nvme_core]
> >>>>> [    4.483269]  ? _raw_spin_unlock_irqrestore+0x25/0x38
> >>>>> [    4.483930]  ? try_to_wake_up+0x38d/0x3b3
> >>>>> [    4.484478]  ? process_one_work+0x179/0x2fc
> >>>>> [    4.485118]  process_one_work+0x1d3/0x2fc
> >>>>> [    4.485655]  ? rescuer_thread+0x2ae/0x2ae
> >>>>> [    4.486196]  worker_thread+0x1e9/0x2be
> >>>>> [    4.486841]  kthread+0x115/0x11d
> >>>>> [    4.487294]  ? kthread_park+0x76/0x76
> >>>>> [    4.487784]  ret_from_fork+0x3a/0x50
> >>>>> [    4.488322] Modules linked in: nvme nvme_core qemu_fw_cfg virtio_scsi ip_tables
> >>>>> [    4.489428] Dumping ftrace buffer:
> >>>>> [    4.489939]    (ftrace buffer empty)
> >>>>> [    4.490492] CR2: 0000000000000098
> >>>>> [    4.491052] ---[ end trace 03cd268ad5a86ff7 ]---
> >>>>>
> >>>>> Cc: Jens Axboe <axboe at kernel.dk>
> >>>>> Cc: David Milburn <dmilburn at redhat.com>
> >>>>> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> >>>>> ---
> >>>>>  drivers/nvme/host/pci.c | 9 +++++++++
> >>>>>  1 file changed, 9 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >>>>> index 7732c4979a4e..86789921f463 100644
> >>>>> --- a/drivers/nvme/host/pci.c
> >>>>> +++ b/drivers/nvme/host/pci.c
> >>>>> @@ -31,6 +31,7 @@
> >>>>>  #include <linux/io-64-nonatomic-lo-hi.h>
> >>>>>  #include <linux/sed-opal.h>
> >>>>>  #include <linux/pci-p2pdma.h>
> >>>>> +#include <linux/crash_dump.h>
> >>>>>  
> >>>>>  #include "nvme.h"
> >>>>>  
> >>>>> @@ -253,6 +254,14 @@ static inline void _nvme_check_size(void)
> >>>>>  
> >>>>>  static unsigned int max_io_queues(void)
> >>>>>  {
> >>>>> +	/*
> >>>>> +	 * blk-mq may set set->nr_hw_queues as 1 during allocating tagset
> >>>>> +	 * in case of kdump kernel. However, queue mapping can be setup
> >>>>> +	 * before allocating tagset, so limit the max io queues as 1 if
> >>>>> +	 * running from kdump kernel.
> >>>>> +	 */
> >>>>> +	if (is_kdump_kernel())
> >>>>> +		return 1;
> >>>>>  	return num_possible_cpus() + write_queues + poll_queues;
> >>>>>  }
> >>>>
> >>>> Hmm, can we do this in blk-mq instead? Seems kind of shady to have to
> >>>> be aware of this in the driver. Something like the below? Totally
> >>>> untested.
> >>>>
> >>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>>> index 900550594651..38beb0de5088 100644
> >>>> --- a/block/blk-mq.c
> >>>> +++ b/block/blk-mq.c
> >>>> @@ -3028,9 +3028,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> >>>>  	 * memory constrained environment. Limit us to 1 queue and
> >>>>  	 * 64 tags to prevent using too much memory.
> >>>>  	 */
> >>>> -	if (is_kdump_kernel()) {
> >>>> -		set->nr_hw_queues = 1;
> >>>> +	if (is_kdump_kernel() && set->nr_hw_queues > 1) {
> >>>>  		set->queue_depth = min(64U, set->queue_depth);
> >>>> +		blk_mq_update_nr_hw_queues(set, 1);
> >>>
> >>> It can't make a difference.
> >>>
> >>> The queue mapping is built via pci_alloc_irq_vectors_affinity() in nvme
> >>> reset work fn. However, .map_queues(nvme_pci_map_queues()) won't trigger
> >>> nvme reset, so blk_mq_update_nr_hw_queues() still uses the old built
> >>> mapping.
> >>>
> >>> That might be an generic issue with blk_mq_update_nr_hw_queues(), but
> >>> I guess it might not trigger a kernel panic when it is called via nvme_dev_add().
> >>
> >> See the later one, it worked for me. This one was untested, as mentioned.
> > 
> > Looks there is still the panic in my test, as I mentioned, the old mapping
> > can't be updated by the patch, and all other hw queues(index > 0) can be
> > retrieved via CPU index.
> 
> Which one did you try? Worked for me. Not saying there can't be an issue...

The later one with single queue/single queue map, follows the patch I
applied exactly:

[mingl at hp-dl380g10-01 kernel]$ git diff
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900550594651..2f0725f3f59c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2810,6 +2810,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
  */
 static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
 {
+      if (/*is_kdump_kernel()*/1)
+            return 1;
+
        if (set->nr_maps == 1)
                return nr_cpu_ids;
 
@@ -3028,9 +3031,11 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
         * memory constrained environment. Limit us to 1 queue and
         * 64 tags to prevent using too much memory.
         */
-       if (is_kdump_kernel()) {
+       if (/*is_kdump_kernel()*/1) {
                set->nr_hw_queues = 1;
                set->queue_depth = min(64U, set->queue_depth);
+               //blk_mq_update_nr_hw_queues(set, 1);
+               set->nr_maps = 1;
        }

The former patch doesn't work too.

The issue is that we only allocate one hw_ctx instance in case of kdump,
however, we may map to other hctx by the old mapping, then kernel panic
is triggered on cpumask_test_cpu(i, hctx->cpumask)) in
blk_mq_map_swqueue().

> If we are going to modify the driver to fix it, it should be by some
> exported function. It seems kind of nasty to have implied kdump specific
> knowledge in the driver.

I agree it is just one workaround, and I actually mentioned that in Red Hat
internal BZ.

Another approach may be to use blk_mq_map_queues() to re-build the
mapping by passing .nr_queues as 1.

Thanks,
Ming
