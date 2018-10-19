From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 19 Oct 2018 09:23:32 -0700
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <9716592b-6175-600d-c1a1-593cd3145b39@grimberg.me>
References: <20180927180031.10706-1-sagi@grimberg.me>
 <CAO+b5-oBVw=-wvnWk1EF=RBaZtjX6bjUG+3WABXbvzX9UTu26w@mail.gmail.com>
 <9716592b-6175-600d-c1a1-593cd3145b39@grimberg.me>
Message-ID: <1539966212.81977.53.camel@acm.org>

On Thu, 2018-10-18@18:08 -0700, Sagi Grimberg wrote:
+AD4 +AD4 It seems like this has not yet been fixed entirely. This is what appeared
+AD4 +AD4 in the kernel log this morning on my test setup with Christoph's nvme-4.20
+AD4 +AD4 branch (commit cb4bfda62afa (+ACI-nvme-pci: fix hot removal during error
+AD4 +AD4 handling+ACI)):
+AD4 
+AD4 There is something I'm missing here, the id+AF8-priv-+AD4-handler+AF8-mutex that the
+AD4 connect context is running on is guaranteed to be different than the
+AD4 one being removed (a different cm+AF8-id) and also the workqueues are
+AD4 different.
+AD4 
+AD4 Is it not allowed to flush workqueue A from a work that is hosted on
+AD4 workqueue B?

Hi Tejun and Johannes,

It seems like we ran into a lockdep complaint triggered by a recently queued
patch (87915adc3f0a (+ACI-workqueue: re-add lockdep dependencies for flushing+ACI)).
However, it's not clear to us whether anything is wrong with the code the
complaint refers to. Can any of you have a look? I have attached the lockep
complaint to this e-mail.

Thanks,

Bart.
-------------- next part --------------
======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc6-dbg+ #1 Not tainted
------------------------------------------------------
kworker/u16:7/169 is trying to acquire lock:
00000000578ccf82 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]

but task is already holding lock:
000000005d67271b ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&queue->release_work)){+.+.}:
       process_one_work+0x474/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #2 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}:
       flush_workqueue+0xf3/0x970
       nvmet_rdma_cm_handler+0x1319/0x170f [nvmet_rdma]
       cma_ib_req_handler+0x72f/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_req_handler+0x135b/0x1c30 [ib_cm]
       cm_work_handler+0x2b7/0x38cd [ib_cm]
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

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
       lock_acquire+0xd2/0x210
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
  &id_priv->handler_mutex --> (wq_completion)"nvmet-rdma-delete-wq" --> (work_completion)(&queue->release_work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&queue->release_work));
                               lock((wq_completion)"nvmet-rdma-delete-wq");
                               lock((work_completion)(&queue->release_work));
  lock(&id_priv->handler_mutex);

 *** DEADLOCK ***

2 locks held by kworker/u16:7/169:
 #0: 00000000a32d4be9 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}, at: process_one_work+0x3ed/0xa20
 #1: 000000005d67271b ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20

stack backtrace:
CPU: 1 PID: 169 Comm: kworker/u16:7 Not tainted 4.19.0-rc6-dbg+ #1
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Workqueue: nvmet-rdma-delete-wq nvmet_rdma_release_queue_work [nvmet_rdma]
Call Trace:
 dump_stack+0xa4/0xf5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1a5e/0x1b20
 lock_acquire+0xd2/0x210
 __mutex_lock+0xfe/0xbe0
 mutex_lock_nested+0x1b/0x20
 rdma_destroy_id+0x6f/0x440 [rdma_cm]
 nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
 process_one_work+0x4ae/0xa20
 worker_thread+0x63/0x5a0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30
