From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 20 Sep 2018 10:49:40 -0700
Subject: nvmet: Kernel v4.19-rc4 circular locking complaint
Message-ID: <1537465780.224533.19.camel@acm.org>

Hello,

Here is another complaint that appeared while running the nvmeof-mp tests.
Sagi, I have Cc-ed you because I think that this complaint may be related
to the flush_scheduled_work() call that was inserted in
nvmet_rdma_queue_connect() by commit 777dc82395de ("nvmet-rdma: occasionally
flush ongoing controller teardown"). It seems weird to me that work is
flushed from the context of an RDMA/CM handler, which is running in the
context of a work item itself.

Bart.

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc4-dbg+ #3 Not tainted
------------------------------------------------------
kworker/5:0/39 is trying to acquire lock:
00000000a10b6db9 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]

but task is already holding lock:
00000000331b4e2c ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&queue->release_work)){+.+.}:
       process_one_work+0x474/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #2 ((wq_completion)"events"){+.+.}:
       flush_workqueue+0xf3/0x970
       nvmet_rdma_cm_handler+0x133d/0x1734 [nvmet_rdma]
       cma_ib_req_handler+0x72f/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_req_handler+0x135b/0x1c30 [ib_cm]
       cm_work_handler+0x2b7/0x38cd [ib_cm]
       process_one_work+0x4ae/0xa20
nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: disconnected (10): status 0 id 0000000040357082
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
nvme nvme0: Reconnecting in 10 seconds...

-> #1 (&id_priv->handler_mutex/1){+.+.}:
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       cma_ib_req_handler+0x6aa/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_req_handler+0x135b/0x1c30 [ib_cm]
       cm_work_handler+0x2b7/0x38cd [ib_cm]
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #0 (&id_priv->handler_mutex){+.+.}:
       lock_acquire+0xc5/0x200
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       rdma_destroy_id+0x6f/0x440 [rdma_cm]
       nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

other info that might help us debug this:

Chain exists of:
  &id_priv->handler_mutex --> (wq_completion)"events" --> (work_completion)(&queue->release_work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&queue->release_work));
                               lock((wq_completion)"events");
                               lock((work_completion)(&queue->release_work));
  lock(&id_priv->handler_mutex);

 *** DEADLOCK ***

2 locks held by kworker/5:0/39:
 #0: 0000000071b4905b ((wq_completion)"events"){+.+.}, at: process_one_work+0x3ed/0xa20
 #1: 00000000331b4e2c ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20

stack backtrace:
CPU: 5 PID: 39 Comm: kworker/5:0 Not tainted 4.19.0-rc4-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1a54/0x1b20
print_req_error: I/O error, dev dm-0, sector 65528
print_req_error: I/O error, dev dm-0, sector 65528
Buffer I/O error on dev dm-0, logical block 8191, async page read
print_req_error: I/O error, dev dm-0, sector 0
 lock_acquire+0xc5/0x200
Buffer I/O error on dev dm-0, logical block 0, async page read
 __mutex_lock+0xfe/0xbe0
print_req_error: I/O error, dev dm-0, sector 0
Buffer I/O error on dev dm-0, logical block 0, async page read
Buffer I/O error on dev dm-0, logical block 3, async page read
 mutex_lock_nested+0x1b/0x20
 rdma_destroy_id+0x6f/0x440 [rdma_cm]
 nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
 process_one_work+0x4ae/0xa20
 worker_thread+0x63/0x5a0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30
