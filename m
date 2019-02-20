From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 20 Feb 2019 11:11:23 +0800
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Message-ID: <20190220031122.GA17298@ming.t460p>

Hi,

The kernel oops[1] is observed when the following commit is applied.
And the panic disappears after it is reverted.


commit 6e02318eaea53eaafe628c4ffc254f57b2704561
Author: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Date:   Mon Dec 17 22:42:03 2018 -0500

    nvme: add support for the Write Zeroes command



[1] panic log
[   40.360720] ------------[ cut here ]------------
[   40.361396] kernel BUG at lib/sg_pool.c:103!
[   40.362042] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   40.362918] CPU: 2 PID: 400 Comm: kworker/2:1H Not tainted 5.0.0-rc4_6e02318eaea5+ #125
[   40.364021] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[   40.365224] Workqueue: kblockd blk_mq_run_work_fn
[   40.365930] RIP: 0010:sg_alloc_table_chained+0x7/0x6b
[   40.366632] Code: 8d 56 ff 0f bd c6 85 f2 0f 95 c2 0f b6 d2 01 d0 83 e8 03 48 c1 e0 05 48 8b b0 98 b7 13 82 e9 4f ed e0 ff 85 f6 55 53 51 75 02 <0f> 0b 48 85 d2 48 89 d1 48 89 fb 40 0f 95 c5 81 fe 80 00 00 00 7f
[   40.369197] RSP: 0000:ffffc9000075bc60 EFLAGS: 00010246
[   40.369927] RAX: ffff8880251b2698 RBX: ffff8880255db7c0 RCX: ffff88803696a368
[   40.370913] RDX: ffff8880251b26a8 RSI: 0000000000000000 RDI: ffff8880251b2698
[   40.371896] RBP: ffff888072048950 R08: 00000000000003e8 R09: 0000000000000001
[   40.372877] R10: ffff8880255e0868 R11: 0000000000000001 R12: ffff888035d4c100
[   40.373853] R13: ffff88806b282d80 R14: ffff8880251b2480 R15: ffffc9000075bd3c
[   40.374835] FS:  0000000000000000(0000) GS:ffff888079c00000(0000) knlGS:0000000000000000
[   40.375941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.376739] CR2: 00007f1e739be000 CR3: 0000000024cb0002 CR4: 0000000000760ee0
[   40.377732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   40.378711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   40.379692] PKRU: 55555554
[   40.380076] Call Trace:
[   40.380447]  nvme_rdma_queue_rq+0x310/0x5d7 [nvme_rdma]
[   40.381185]  blk_mq_try_issue_directly+0x112/0x1f0
[   40.381868]  blk_insert_cloned_request+0xdf/0xfb
[   40.382522]  ? ktime_get+0x3f/0x92
[   40.383032]  dm_mq_queue_rq+0x29f/0x36b [dm_mod]
[   40.383696]  ? __switch_to_asm+0x40/0x70
[   40.384246]  blk_mq_dispatch_rq_list+0x28d/0x45d
[   40.384898]  ? _raw_spin_unlock+0x16/0x27
[   40.385451]  ? blk_mq_flush_busy_ctxs+0x8a/0x17c
[   40.386105]  blk_mq_sched_dispatch_requests+0x129/0x14b
[   40.386864]  __blk_mq_run_hw_queue+0xa4/0xcc
[   40.387475]  process_one_work+0x1c9/0x302
[   40.388054]  ? rescuer_thread+0x282/0x282
[   40.388614]  worker_thread+0x1ca/0x295
[   40.389151]  kthread+0x115/0x11d
[   40.389612]  ? kthread_park+0x76/0x76
[   40.390128]  ret_from_fork+0x35/0x40
[   40.390640] Modules linked in: nvme_rdma nvme_fabrics nvmet_rdma rdma_cm iw_cm ib_cm nvmet crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel ib_core null_blk scsi_debug isofs dm_service_time iTCO_wdt iTCO_vendor_support i2c_i801 i2c_core lpc_ich mfd_core ip_tables sr_mod cdrom usb_storage sd_mod ahci libahci libata crc32c_intel virtio_scsi qemu_fw_cfg dm_mirror dm_region_hash dm_log dm_multipath dm_mod
[   40.395481] Dumping ftrace buffer:
[   40.395996]    (ftrace buffer empty)
[   40.396532] ---[ end trace c0ae1e79f5f72e15 ]---

Thanks,
Ming
