From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 3 Jan 2016 03:40:52 -0800
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160102213008.GA10969@localhost.localdomain>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
 <20160102170730.GA30184@infradead.org>
 <20160102213008.GA10969@localhost.localdomain>
Message-ID: <20160103114052.GA24893@infradead.org>

On Sat, Jan 02, 2016@09:30:09PM +0000, Keith Busch wrote:
> The async deletion was written for a bug reporting "hang" on a device
> removal. The "hang" was the controller taking on the order of 100's msec
> to delete a queue (sometimes >1sec if lots of commands queued). This
> controller had 2k queues, and took ~15 minutes to remove serially. Async
> deletion brought it down to ~20 seconds, so looked like a good idea.
> 
> It wasn't a controller I make, so I personally don't care about
> parallelizing queue deletion. The driver's been this way for so long
> though, I don't have a good way to know how beneficial this feature
> is anymore.

How about something like the lightly tested patch below.  It uses
synchronous command submission, but schedules a work item on the
system unbound workqueue for each queue, allowing the scheduler
to execture them in parallel.

---
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 3 Jan 2016 12:09:36 +0100
Subject: nvme: semi-synchronous queue deletion

Replace the complex async queue deletetion scheme with a a work_item
per queue that is scheduled to the system unbound workqueue.  That
way we can use the normal synchronous command submission helpers,
but let the scheduler distribute the deletions over all available
CPUs.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 180 +++++++-----------------------------------------
 1 file changed, 25 insertions(+), 155 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82bbea..68ba2d4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -89,13 +89,6 @@ static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
 static void nvme_dev_shutdown(struct nvme_dev *dev);
 
-struct async_cmd_info {
-	struct kthread_work work;
-	struct kthread_worker *worker;
-	int status;
-	void *ctx;
-};
-
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -128,6 +121,10 @@ struct nvme_dev {
 #define NVME_CTRL_RESETTING    0
 
 	struct nvme_ctrl ctrl;
+
+	/* for queue deletion at shutdown time */
+	atomic_t		queues_remaining;
+	wait_queue_head_t	queue_delete_wait;
 };
 
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
@@ -159,7 +156,7 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
-	struct async_cmd_info cmdinfo;
+	struct work_struct work; /* for queue deletion */
 };
 
 /*
@@ -844,15 +841,6 @@ static void nvme_submit_async_event(struct nvme_dev *dev)
 	__nvme_submit_cmd(dev->queues[0], &c);
 }
 
-static void async_cmd_info_endio(struct request *req, int error)
-{
-	struct async_cmd_info *cmdinfo = req->end_io_data;
-
-	cmdinfo->status = req->errors;
-	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
-	blk_mq_free_request(req);
-}
-
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	struct nvme_command c;
@@ -1706,157 +1694,39 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	}
 }
 
-struct nvme_delq_ctx {
-	struct task_struct *waiter;
-	struct kthread_worker *worker;
-	atomic_t refcount;
-};
-
-static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
-{
-	dq->waiter = current;
-	mb();
-
-	for (;;) {
-		set_current_state(TASK_KILLABLE);
-		if (!atomic_read(&dq->refcount))
-			break;
-		if (!schedule_timeout(ADMIN_TIMEOUT) ||
-					fatal_signal_pending(current)) {
-			/*
-			 * Disable the controller first since we can't trust it
-			 * at this point, but leave the admin queue enabled
-			 * until all queue deletion requests are flushed.
-			 * FIXME: This may take a while if there are more h/w
-			 * queues than admin tags.
-			 */
-			set_current_state(TASK_RUNNING);
-			nvme_disable_ctrl(&dev->ctrl,
-				lo_hi_readq(dev->bar + NVME_REG_CAP));
-			nvme_clear_queue(dev->queues[0]);
-			flush_kthread_worker(dq->worker);
-			nvme_disable_queue(dev, 0);
-			return;
-		}
-	}
-	set_current_state(TASK_RUNNING);
-}
-
-static void nvme_put_dq(struct nvme_delq_ctx *dq)
-{
-	atomic_dec(&dq->refcount);
-	if (dq->waiter)
-		wake_up_process(dq->waiter);
-}
-
-static struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
+static void nvme_disable_queue_work(struct work_struct *work)
 {
-	atomic_inc(&dq->refcount);
-	return dq;
-}
-
-static void nvme_del_queue_end(struct nvme_queue *nvmeq)
-{
-	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
-	nvme_put_dq(dq);
-
-	spin_lock_irq(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
-}
-
-static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
-						kthread_work_func_t fn)
-{
-	struct request *req;
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
-	c.delete_queue.opcode = opcode;
-	c.delete_queue.qid = cpu_to_le16(nvmeq->qid);
-
-	init_kthread_work(&nvmeq->cmdinfo.work, fn);
-
-	req = nvme_alloc_request(nvmeq->dev->ctrl.admin_q, &c, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->timeout = ADMIN_TIMEOUT;
-	req->end_io_data = &nvmeq->cmdinfo;
-	blk_execute_rq_nowait(req->q, NULL, req, 0, async_cmd_info_endio);
-	return 0;
-}
-
-static void nvme_del_cq_work_handler(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
-							cmdinfo.work);
-	nvme_del_queue_end(nvmeq);
-}
-
-static int nvme_delete_cq(struct nvme_queue *nvmeq)
-{
-	return adapter_async_del_queue(nvmeq, nvme_admin_delete_cq,
-						nvme_del_cq_work_handler);
-}
-
-static void nvme_del_sq_work_handler(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
-							cmdinfo.work);
-	int status = nvmeq->cmdinfo.status;
-
-	if (!status)
-		status = nvme_delete_cq(nvmeq);
-	if (status)
-		nvme_del_queue_end(nvmeq);
-}
+	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue, work);
+	struct nvme_dev *dev = nvmeq->dev;
 
-static int nvme_delete_sq(struct nvme_queue *nvmeq)
-{
-	return adapter_async_del_queue(nvmeq, nvme_admin_delete_sq,
-						nvme_del_sq_work_handler);
-}
+	nvme_disable_queue(dev, nvmeq->qid);
 
-static void nvme_del_queue_start(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
-							cmdinfo.work);
-	if (nvme_delete_sq(nvmeq))
-		nvme_del_queue_end(nvmeq);
+	if (atomic_dec_and_test(&dev->queues_remaining))
+		wake_up(&dev->queue_delete_wait);
 }
 
+/*
+ * Disable all I/O queues.
+ *
+ * We use the system unboud workqueue to allow parallel execution of
+ * long-running deletes.
+ */
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
 	int i;
-	DEFINE_KTHREAD_WORKER_ONSTACK(worker);
-	struct nvme_delq_ctx dq;
-	struct task_struct *kworker_task = kthread_run(kthread_worker_fn,
-					&worker, "nvme%d", dev->ctrl.instance);
-
-	if (IS_ERR(kworker_task)) {
-		dev_err(dev->dev,
-			"Failed to create queue del task\n");
-		for (i = dev->queue_count - 1; i > 0; i--)
-			nvme_disable_queue(dev, i);
-		return;
-	}
 
-	dq.waiter = NULL;
-	atomic_set(&dq.refcount, 0);
-	dq.worker = &worker;
+	atomic_set(&dev->queues_remaining, dev->queue_count - 1);
+	init_waitqueue_head(&dev->queue_delete_wait);
+
 	for (i = dev->queue_count - 1; i > 0; i--) {
 		struct nvme_queue *nvmeq = dev->queues[i];
 
-		if (nvme_suspend_queue(nvmeq))
-			continue;
-		nvmeq->cmdinfo.ctx = nvme_get_dq(&dq);
-		nvmeq->cmdinfo.worker = dq.worker;
-		init_kthread_work(&nvmeq->cmdinfo.work, nvme_del_queue_start);
-		queue_kthread_work(dq.worker, &nvmeq->cmdinfo.work);
+		INIT_WORK(&nvmeq->work, nvme_disable_queue_work);
+		queue_work(system_unbound_wq, &nvmeq->work);
 	}
-	nvme_wait_dq(&dq, dev);
-	kthread_stop(kworker_task);
+
+	wait_event(dev->queue_delete_wait,
+		   atomic_read(&dev->queues_remaining) == 0);
 }
 
 static int nvme_dev_list_add(struct nvme_dev *dev)
-- 
1.9.1
