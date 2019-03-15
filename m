From: kbusch@kernel.org (Keith Busch)
Date: Fri, 15 Mar 2019 10:38:43 -0600
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190315162837.GA27308@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me>
 <20190312143231.GA1149@lst.de>
 <8a80ce70-0b98-6c82-a47c-f312a41d2d2a@grimberg.me>
 <20190315162837.GA27308@lst.de>
Message-ID: <20190315163843.GA18289@localhost.localdomain>

On Fri, Mar 15, 2019@05:28:37PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 12, 2019@02:15:26PM -0700, Sagi Grimberg wrote:
> >
> >> I like the idea behind this, but it looks rather convoluted.  I think
> >> for the unusable namespace case we should warn and have a common label
> >> that just sets the capacity, not touching anything else.
> >>
> >> Does something like this work for you?
> >
> > No, this is what I had done originally, but we need to always have the
> > queue set to a decent block size, otherwise blk_queue_stack_limits()
> > panics on div by 0..
> 
> I actually tested it by manually hacking a 8k block size into nvmet
> and and it works just fine for me.  Where do you see a division by
> zero with this patch exactly?

I'm not sure abuot a divide-by-zero, but I just hacked up qemu to report
an 8k block size and get this on boot. Happens because alloc_page_buffers
won't allocate a buffer_head when block size is greater than a page size:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
 #PF error: [normal kernel read fault]
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP
 CPU: 3 PID: 391 Comm: kworker/u18:1 Not tainted 5.0.0+ #42
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
 Workqueue: nvme-wq nvme_scan_work [nvme_core]
 RIP: 0010:create_empty_buffers+0x24/0x100
 Code: eb cb 0f 1f 40 00 0f 1f 44 00 00 41 54 55 49 89 d4 53 ba 01 00 00 00 48 89 fb e8 87 fe ff ff 48 89 c5 48 89 c2 eb 03 48 89 ca <48> 8b 4a 08 4c 09 22 48 85 c9 75 f1 48 89 6a 08 48 8b 43 18 48 8d
 RSP: 0018:ffffbd9ec05cf880 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffe0fec03a38c0 RCX: ffff99f4c751d000
 RDX: 0000000000000000 RSI: ffff99f4c751d000 RDI: ffffe0fec03a38c0
 RBP: 0000000000000000 R08: dead0000000000ff R09: 0000000000000003
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000200 R15: ffffe0fec03a38c0
 FS:  0000000000000000(0000) GS:ffff99f4cfd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000000eb28000 CR4: 00000000000006e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  create_page_buffers+0x4d/0x60
  block_read_full_page+0x47/0x310
  ? __add_to_page_cache_locked+0x288/0x330
  ? check_disk_change+0x60/0x60
  ? count_shadow_nodes+0x130/0x130
  do_read_cache_page+0x31c/0x6b0
  ? blkdev_writepages+0x10/0x10
  read_dev_sector+0x28/0xc0
  read_lba+0x126/0x210
  ? kmem_cache_alloc_trace+0x19b/0x1b0
  efi_partition+0x137/0x780
  ? vsnprintf+0x2ae/0x4a0
  ? vsnprintf+0xec/0x4a0
  ? snprintf+0x45/0x70
  ? is_gpt_valid.part.6+0x400/0x400
  ? check_partition+0x137/0x240
  check_partition+0x137/0x240
  rescan_partitions+0xab/0x350
  __blkdev_get+0x342/0x560
  ? inode_insert5+0x11f/0x1e0
  blkdev_get+0x11f/0x310
  ? unlock_new_inode+0x44/0x60
  ? bdget+0xff/0x110
  __device_add_disk+0x426/0x470
  nvme_validate_ns+0x35e/0x7c0 [nvme_core]
  ? nvme_identify_ctrl.isra.56+0x7e/0xc0 [nvme_core]
  ? update_load_avg+0x89/0x550
  nvme_scan_work+0xe5/0x370 [nvme_core]
  ? __synchronize_srcu.part.18+0x91/0xc0
  ? try_to_wake_up+0x55/0x430
  process_one_work+0x1e9/0x3e0
  worker_thread+0x21a/0x3d0
  ? process_one_work+0x3e0/0x3e0
  kthread+0x111/0x130
  ? kthread_park+0x90/0x90
  ret_from_fork+0x1f/0x30
 Modules linked in: nvme nvme_core serio_raw
 CR2: 0000000000000008
 ---[ end trace b38bdf1b424f36e9 ]---
