From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 22 Oct 2018 08:18:18 -0700
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for flushing"
Message-ID: <20181022151818.135163-1-bvanassche@acm.org>

Lockdep is a tool that developers rely on to find actual bugs. False
positive lockdep warnings are very annoying because it takes time to
analyze these and to verify that the warning is really a false positive
report. Since commit 87915adc3f0a ("workqueue: re-add lockdep
dependencies for flushing") causes lockdep to produce multiple false
positive reports, revert that commit. An example of a false positive
report produced by that commit:

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc1-dbg+ #1 Not tainted
------------------------------------------------------
fio/29348 is trying to acquire lock:
00000000f1894b1d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at: flush_workqueue+0xd0/0x970

but task is already holding lock:
000000007d8b84da (&sb->s_type->i_mutex_key#16){++++}, at: ext4_file_write_iter+0x154/0x710

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#16){++++}:
       down_write+0x3d/0x80
       __generic_file_fsync+0x77/0xf0
       ext4_sync_file+0x3c9/0x780
       vfs_fsync_range+0x66/0x100
       dio_complete+0x2f5/0x360
       dio_aio_complete_work+0x1c/0x20
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #1 ((work_completion)(&dio->complete_work)){+.+.}:
       process_one_work+0x474/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #0 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
       lock_acquire+0xc5/0x200
       flush_workqueue+0xf3/0x970
       drain_workqueue+0xec/0x220
       destroy_workqueue+0x23/0x350
       sb_init_dio_done_wq+0x6a/0x80
       do_blockdev_direct_IO+0x3b8/0x3d00
       __blockdev_direct_IO+0x79/0x86
       ext4_direct_IO+0x5df/0xbc0
       generic_file_direct_write+0x119/0x220
       __generic_file_write_iter+0x131/0x2d0
       ext4_file_write_iter+0x3fa/0x710
       aio_write+0x235/0x330
       io_submit_one+0x510/0xeb0
       __x64_sys_io_submit+0x122/0x340
       do_syscall_64+0x71/0x220
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  (wq_completion)"dio/%s"sb->s_id --> (work_completion)(&dio->complete_work) --> &sb->s_type->i_mutex_key#16

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#16);
                               lock((work_completion)(&dio->complete_work));
                               lock(&sb->s_type->i_mutex_key#16);
  lock((wq_completion)"dio/%s"sb->s_id);

 *** DEADLOCK ***

1 lock held by fio/29348:
 #0: 000000007d8b84da (&sb->s_type->i_mutex_key#16){++++}, at: ext4_file_write_iter+0x154/0x710

stack backtrace:
CPU: 4 PID: 29348 Comm: fio Not tainted 4.19.0-rc1-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1a54/0x1b20
 lock_acquire+0xc5/0x200
 flush_workqueue+0xf3/0x970
 drain_workqueue+0xec/0x220
 destroy_workqueue+0x23/0x350
 sb_init_dio_done_wq+0x6a/0x80
 do_blockdev_direct_IO+0x3b8/0x3d00
 __blockdev_direct_IO+0x79/0x86
 ext4_direct_IO+0x5df/0xbc0
 generic_file_direct_write+0x119/0x220
 __generic_file_write_iter+0x131/0x2d0
 ext4_file_write_iter+0x3fa/0x710
 aio_write+0x235/0x330
 io_submit_one+0x510/0xeb0
 __x64_sys_io_submit+0x122/0x340
 do_syscall_64+0x71/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing")
Cc: Johannes Berg <johannes.berg at intel.com>
Cc: Tejun Heo <tj at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org <linux-nvme at lists.infradead.org>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 kernel/workqueue.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 60e80198c3df..a6c2b823f348 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2652,9 +2652,6 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
-
 	mutex_lock(&wq->mutex);
 
 	/*
@@ -2908,11 +2905,6 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
-	if (!from_cancel) {
-		lock_map_acquire(&work->lockdep_map);
-		lock_map_release(&work->lockdep_map);
-	}
-
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
-- 
2.19.1.568.g152ad8e336-goog
