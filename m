From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Oct 2018 14:01:28 -0700
Subject: [PATCH v2 1/2] nvmet-rdma: Rework DoS attack mitigation
In-Reply-To: <20181025210129.96766-1-bvanassche@acm.org>
References: <20181025210129.96766-1-bvanassche@acm.org>
Message-ID: <20181025210129.96766-2-bvanassche@acm.org>

When the rate of connect / disconnect requests is high, temporarily
refuse connections instead of waiting until previous connections have
been cleaned up. This patch avoids that the lockdep complaint shown
below is reported. See also the following commits:
* 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
* 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown").

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
Cc: Johannes Berg <johannes.berg at intel.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/rdma.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bd265aceb90c..c12ffbc90488 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -127,6 +127,8 @@ static bool nvmet_rdma_use_srq;
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
 
+#define MAX_QUEUES_BEING_RELEASED 16
+static atomic_t queues_being_released;
 static DEFINE_IDA(nvmet_rdma_queue_ida);
 static LIST_HEAD(nvmet_rdma_queue_list);
 static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
@@ -891,6 +893,8 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	ib_dealloc_pd(ndev->pd);
 
 	kfree(ndev);
+
+	atomic_dec(&queues_being_released);
 }
 
 static struct nvmet_rdma_device *
@@ -1253,6 +1257,13 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	struct nvmet_rdma_queue *queue;
 	int ret = -EINVAL;
 
+	if (atomic_read(&queues_being_released) >
+	    MAX_QUEUES_BEING_RELEASED) {
+		pr_warn_ratelimited("The rate at which initiator systems connect and disconnect seems to be high. New connections will be refused temporarily.\n");
+		nvmet_rdma_cm_reject(cm_id, NVME_RDMA_CM_NO_RSC);
+		return -ECONNREFUSED;
+	}
+
 	ndev = nvmet_rdma_find_get_device(cm_id);
 	if (!ndev) {
 		nvmet_rdma_cm_reject(cm_id, NVME_RDMA_CM_NO_RSC);
@@ -1266,14 +1277,11 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	}
 	queue->port = cm_id->context;
 
-	if (queue->host_qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_rdma_delete_wq);
-	}
-
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
 	if (ret) {
-		queue_work(nvmet_rdma_delete_wq, &queue->release_work);
+		atomic_inc(&queues_being_released);
+		WARN_ON_ONCE(!queue_work(nvmet_rdma_delete_wq,
+					 &queue->release_work));
 		/* Destroying rdma_cm id is not needed here */
 		return 0;
 	}
@@ -1338,7 +1346,9 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 
 	if (disconnect) {
 		rdma_disconnect(queue->cm_id);
-		queue_work(nvmet_rdma_delete_wq, &queue->release_work);
+		atomic_inc(&queues_being_released);
+		WARN_ON_ONCE(!queue_work(nvmet_rdma_delete_wq,
+					 &queue->release_work));
 	}
 }
 
@@ -1368,7 +1378,8 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	pr_err("failed to connect queue %d\n", queue->idx);
-	queue_work(nvmet_rdma_delete_wq, &queue->release_work);
+	atomic_inc(&queues_being_released);
+	WARN_ON_ONCE(!queue_work(nvmet_rdma_delete_wq, &queue->release_work));
 }
 
 /**
-- 
2.19.1.568.g152ad8e336-goog
