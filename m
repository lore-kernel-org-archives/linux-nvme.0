From: keith.busch@intel.com (Keith Busch)
Date: Mon,  4 Jan 2016 09:10:58 -0700
Subject: [PATCHv3 4/5] NVMe: IO queue deletion re-write
In-Reply-To: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451923859-14187-5-git-send-email-keith.busch@intel.com>

The nvme driver deletes IO queues asynchronously since this operation
may potentially take an undesirable amount of time with a large number
of queues if done serially.

The driver used to manage coordinating asynchronous deletions. This
patch simplifies that by leveraging the block layer rather than using
kthread workers and chaining more complicated callbacks.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 250 ++++++++++++++++--------------------------------
 1 file changed, 80 insertions(+), 170 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 953fe48..49829a7 100644
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
@@ -125,9 +118,11 @@ struct nvme_dev {
 	u64 cmb_size;
 	u32 cmbsz;
 	unsigned long flags;
+
 #define NVME_CTRL_RESETTING    0
 
 	struct nvme_ctrl ctrl;
+	struct completion ioq_wait;
 };
 
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
@@ -159,7 +154,7 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
-	struct async_cmd_info cmdinfo;
+	struct nvme_delete_queue dq;
 };
 
 /*
@@ -844,15 +839,6 @@ static void nvme_submit_async_event(struct nvme_dev *dev)
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
@@ -1600,6 +1586,82 @@ static void nvme_dev_scan(struct work_struct *work)
 	nvme_set_irq_hints(dev);
 }
 
+static void nvme_del_queue_end(struct request *req, int error)
+{
+	unsigned long flags;
+	struct nvme_queue *nvmeq = req->end_io_data;
+
+	blk_mq_free_request(req);
+
+	spin_lock_irqsave(&nvmeq->q_lock, flags);
+	nvme_process_cq(nvmeq);
+	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+
+	complete(&nvmeq->dev->ioq_wait);
+}
+
+static void nvme_del_sq_end(struct request *req, int error)
+{
+	struct nvme_queue *nvmeq = req->end_io_data;
+
+	if (error) {
+		nvme_del_queue_end(req, error);
+		return;
+	}
+
+	nvmeq->dq.opcode = nvme_admin_delete_cq;
+	req->end_io = nvme_del_queue_end;
+
+	/* Must requeue. This callback occurs in irq w/ q_lock held */
+	nvme_requeue_req(req);
+}
+
+static int nvme_delete_queue(struct nvme_queue *nvmeq, struct request_queue *q)
+{
+	struct request *req;
+
+	req = nvme_alloc_request(q, (struct nvme_command *)&nvmeq->dq,
+							BLK_MQ_REQ_NOWAIT);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	memset(&nvmeq->dq, 0, sizeof(nvmeq->dq));
+	nvmeq->dq.opcode = nvme_admin_delete_sq;
+	nvmeq->dq.qid = cpu_to_le16(nvmeq->qid);
+
+	req->end_io_data = nvmeq;
+	req->timeout = ADMIN_TIMEOUT;
+
+	blk_execute_rq_nowait(q, NULL, req, false, nvme_del_sq_end);
+	return 0;
+}
+
+static void nvme_disable_io_queues(struct nvme_dev *dev)
+{
+	struct request_queue *q = dev->ctrl.admin_q;
+	int i = dev->queue_count - 1, sent = 0;
+	unsigned long timeout;
+
+	reinit_completion(&dev->ioq_wait);
+ retry:
+	timeout = ADMIN_TIMEOUT;
+	for (; i > 0; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+
+		nvme_suspend_queue(nvmeq);
+		if (nvme_delete_queue(nvmeq, q))
+			break;
+		++sent;
+	}
+	while (sent--) {
+		timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
+		if (timeout == 0)
+			return;
+		if (i)
+			goto retry;
+	}
+}
+
 /*
  * Return: error value if an error occurred setting up the queues or calling
  * Identify Device.  0 if these succeeded, even if adding some of the
@@ -1711,159 +1773,6 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
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
-{
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
-
-static int nvme_delete_sq(struct nvme_queue *nvmeq)
-{
-	return adapter_async_del_queue(nvmeq, nvme_admin_delete_sq,
-						nvme_del_sq_work_handler);
-}
-
-static void nvme_del_queue_start(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
-							cmdinfo.work);
-	if (nvme_delete_sq(nvmeq))
-		nvme_del_queue_end(nvmeq);
-}
-
-static void nvme_disable_io_queues(struct nvme_dev *dev)
-{
-	int i;
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
-
-	dq.waiter = NULL;
-	atomic_set(&dq.refcount, 0);
-	dq.worker = &worker;
-	for (i = dev->queue_count - 1; i > 0; i--) {
-		struct nvme_queue *nvmeq = dev->queues[i];
-
-		if (nvme_suspend_queue(nvmeq))
-			continue;
-		nvmeq->cmdinfo.ctx = nvme_get_dq(&dq);
-		nvmeq->cmdinfo.worker = dq.worker;
-		init_kthread_work(&nvmeq->cmdinfo.work, nvme_del_queue_start);
-		queue_kthread_work(dq.worker, &nvmeq->cmdinfo.work);
-	}
-	nvme_wait_dq(&dq, dev);
-	kthread_stop(kworker_task);
-}
-
 static int nvme_dev_list_add(struct nvme_dev *dev)
 {
 	bool start_thread = false;
@@ -2146,6 +2055,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
+	init_completion(&dev->ioq_wait);
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-- 
2.6.2.307.g37023ba
