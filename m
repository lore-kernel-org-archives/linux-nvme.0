From: bvanassche@acm.org (Bart Van Assche)
Date: Wed,  3 Apr 2019 16:04:02 -0700
Subject: [PATCH] nvmet-rdma: Suppress a lockdep complaint
Message-ID: <20190403230402.119428-1-bvanassche@acm.org>

Although the code that waits for controllers that are being teared down
in nvmet_rdma_queue_connect() is fine, lockdep complains about that code.
Lockdep complains because all release_work instances are assigned the
same static lockdep key. Avoid that lockdep complains by using dynamic
lockdep keys instead of static lockdep keys. See also the following
commits:
* 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
* 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown").
* 108c14858b9e ("locking/lockdep: Add support for dynamic keys").

This patch avoids that lockdep reports the following:

======================================================
WARNING: possible circular locking dependency detected
4.19.0-dbg+ #1 Not tainted
------------------------------------------------------
kworker/u12:0/7 is trying to acquire lock:
00000000c03a91d1 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]

but task is already holding lock:
(work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3c9/0x9f0
which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:
-> #3 ((work_completion)(&queue->release_work)){+.+.}:
       process_one_work+0x447/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
-> #2 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}:
       flush_workqueue+0xf3/0x970
       nvmet_rdma_cm_handler+0x1320/0x170f [nvmet_rdma]
       cma_ib_req_handler+0x72f/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_work_handler+0x431e/0x50ba [ib_cm]
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
-> #1 (&id_priv->handler_mutex/1){+.+.}:
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       cma_ib_req_handler+0x6aa/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_work_handler+0x431e/0x50ba [ib_cm]
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
-> #0 (&id_priv->handler_mutex){+.+.}:
       lock_acquire+0xc5/0x200
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       rdma_destroy_id+0x6f/0x440 [rdma_cm]
       nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
       process_one_work+0x481/0x9f0
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

2 locks held by kworker/u12:0/7:
 #0: 00000000272134f2 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}, at: process_one_work+0x3c9/0x9f0
 #1: 0000000090531fcd ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3c9/0x9f0

               stack backtrace:
CPU: 1 PID: 7 Comm: kworker/u12:0 Not tainted 4.19.0-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: nvmet-rdma-delete-wq nvmet_rdma_release_queue_work [nvmet_rdma]
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1c68/0x1cf0
 lock_acquire+0xc5/0x200
 __mutex_lock+0xfe/0xbe0
 mutex_lock_nested+0x1b/0x20
 rdma_destroy_id+0x6f/0x440 [rdma_cm]
 nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
 process_one_work+0x481/0x9f0
 worker_thread+0x63/0x5a0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Max Gurtovoy <maxg at mellanox.com>
Cc: Hannes Reinecke <hare at suse.de>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/rdma.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ef893addf341..522721f22791 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -90,6 +90,10 @@ struct nvmet_rdma_queue {
 	struct nvmet_rdma_cmd	*cmds;
 
 	struct work_struct	release_work;
+#ifdef CONFIG_LOCKDEP
+	struct lock_class_key	key;
+	struct lockdep_map	lockdep_map;
+#endif
 	struct list_head	rsp_wait_list;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
@@ -1066,6 +1070,10 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
 
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&queue->key);
+#endif
+
 	nvmet_sq_destroy(&queue->nvme_sq);
 
 	nvmet_rdma_destroy_queue_ib(queue);
@@ -1163,6 +1171,11 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+#ifdef CONFIG_LOCKDEP
+	lockdep_register_key(&queue->key);
+	lockdep_init_map(&queue->lockdep_map, "nvmet_rdma_release_work",
+			 &queue->key, 0);
+#endif
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
 
@@ -1178,7 +1191,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	queue->idx = ida_simple_get(&nvmet_rdma_queue_ida, 0, 0, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = NVME_RDMA_CM_NO_RSC;
-		goto out_destroy_sq;
+		goto out_unreg_key;
 	}
 
 	ret = nvmet_rdma_alloc_rsps(queue);
@@ -1217,6 +1230,12 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	nvmet_rdma_free_rsps(queue);
 out_ida_remove:
 	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
+out_unreg_key:
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&queue->key);
+#else
+	;
+#endif
 out_destroy_sq:
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_queue:
-- 
2.21.0.196.g041f5ea1cf98
