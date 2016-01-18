From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Mon, 18 Jan 2016 14:04:38 +0200
Subject: dm-multipath low performance with blk-mq
Message-ID: <569CD4D6.2040908@dev.mellanox.co.il>

Hi All,

I've recently tried out dm-multipath over a "super-fast" nvme device
and noticed a serious lock contention in dm-multipath that requires some
extra attention. The nvme device is a simple loopback device emulation
backed by null_blk device.

With this I've seen dm-multipath pushing around ~470K IOPs while
the native (loopback) nvme performance can easily push up to 1500K+ IOPs.

perf output [1] reveals a huge lock contention on the multipath lock
which is a per-dm_target contention point which seem to defeat the
purpose of blk-mq i/O path.

The two current bottlenecks seem to come from multipath_busy and
__multipath_map. Would it make better sense to move to a percpu_ref
model with freeze/unfreeze logic for updates similar to what blk-mq
is doing?

Thoughts?


[1]:
-  23.67%              fio  [kernel.kallsyms]    [k] 
queued_spin_lock_slowpath
    - queued_spin_lock_slowpath
       - 51.40% _raw_spin_lock_irqsave
          - 99.98% multipath_busy
               dm_mq_queue_rq
               __blk_mq_run_hw_queue
               blk_mq_run_hw_queue
               blk_mq_insert_requests
               blk_mq_flush_plug_list
               blk_flush_plug_list
               blk_finish_plug
               do_io_submit
               SyS_io_submit
               entry_SYSCALL_64_fastpath
             + io_submit
       - 48.05% _raw_spin_lock_irq
          - 100.00% __multipath_map
               multipath_clone_and_map
               target_message
               dispatch_io
               __blk_mq_run_hw_queue
               blk_mq_run_hw_queue
               blk_mq_insert_requests
               blk_mq_flush_plug_list
               blk_flush_plug_list
               blk_finish_plug
               do_io_submit
               SyS_io_submit
               entry_SYSCALL_64_fastpath
             + io_submit
+   1.70%              fio  [kernel.kallsyms]    [k] __blk_mq_run_hw_queue
+   1.56%              fio  fio                  [.] get_io_u
+   1.06%              fio  [kernel.kallsyms]    [k] blk_account_io_start
+   0.92%              fio  fio                  [.] do_io
+   0.82%              fio  [kernel.kallsyms]    [k] do_blockdev_direct_IO
+   0.81%              fio  [kernel.kallsyms]    [k] 
blk_mq_hctx_mark_pending
+   0.75%              fio  [kernel.kallsyms]    [k] __blk_mq_alloc_request
+   0.75%              fio  [kernel.kallsyms]    [k] __bt_get
+   0.69%              fio  [kernel.kallsyms]    [k] do_direct_IO
