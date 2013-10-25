From: keith.busch@intel.com (Keith Busch)
Date: Fri, 25 Oct 2013 16:07:34 -0600
Subject: [PATCH] NVMe: Asynchronous IO queue deletion
Message-ID: <1382738854-30106-1-git-send-email-keith.busch@intel.com>

On device removal or shutdown, this attempts to delete all the IO
queues asynchronously. The queue delete admin command is sent for
every submission queue and, if successful, the callback will delete the
completion queue. If there is any failure, the queue is cleaned up and
internal commands are aborted.

The driver will wait for all outstanding queue deletions to complete
before moving on.

The advantage with this over the previous method is really only apparent
if your device is broken. If it is broken and doesn't respond to commands,
the driver would have synchronously waited 120 seconds for each IO queue
pair delete request to time out. Worse is if you have more queues than
command ids and will be stuck in killable state forever until the user
kills the process.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This is built on top of this patch set for controller reset:

http://merlin.infradead.org/pipermail/linux-nvme/2013-October/000563.html

And more or less obsoletes this one:

http://merlin.infradead.org/pipermail/linux-nvme/2013-September/000394.html

 drivers/block/nvme-core.c |  232 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/nvme.h      |    6 ++
 2 files changed, 213 insertions(+), 25 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 71a952e..4080f45 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -60,6 +60,14 @@ static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 
+struct async_cmd_info {
+	struct kthread_work work;
+	struct kthread_worker *worker;
+	u32 result;
+	int status;
+	void *ctx;
+};
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -85,6 +93,7 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	u8 q_suspended;
+	struct async_cmd_info cmdinfo;
 	unsigned long cmdid_data[];
 };
 
@@ -117,6 +126,18 @@ struct nvme_cmd_info {
 	int aborted;
 };
 
+static void async_completion(struct nvme_dev *dev, void *ctx,
+						struct nvme_completion *cqe)
+{
+	struct async_cmd_info *cmdinfo = ctx;
+
+	if (cqe) {
+		cmdinfo->result = le32_to_cpup(&cqe->result);
+		cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	}
+	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
+}
+
 static struct nvme_cmd_info *nvme_cmd_info(struct nvme_queue *nvmeq)
 {
 	return (void *)&nvmeq->cmdid_data[BITS_TO_LONGS(nvmeq->q_depth)];
@@ -166,7 +187,8 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 {
 	int cmdid;
 	wait_event_killable(nvmeq->sq_full,
-		(cmdid = alloc_cmdid(nvmeq, ctx, handler, timeout)) >= 0);
+		(cmdid = alloc_cmdid(nvmeq, ctx, handler, timeout)) >= 0 ||
+		nvmeq->dev->is_initialised == NVME_DEAD);
 	return (cmdid < 0) ? -EINTR : cmdid;
 }
 
@@ -190,13 +212,15 @@ static void special_completion(struct nvme_dev *dev, void *ctx,
 		return;
 	}
 	if (ctx == CMD_CTX_COMPLETED) {
-		dev_warn(&dev->pci_dev->dev,
+		if (cqe)
+			dev_warn(&dev->pci_dev->dev,
 				"completed id %d twice on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
 	}
 	if (ctx == CMD_CTX_INVALID) {
-		dev_warn(&dev->pci_dev->dev,
+		if (cqe)
+			dev_warn(&dev->pci_dev->dev,
 				"invalid id %d completed on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
@@ -238,6 +262,10 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 	ctx = info[cmdid].ctx;
 	info[cmdid].fn = special_completion;
 	info[cmdid].ctx = CMD_CTX_CANCELLED;
+
+	nvmeq->dev->is_initialised = NVME_DEAD;
+	wake_up(&nvmeq->sq_full);
+
 	return ctx;
 }
 
@@ -355,7 +383,7 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 {
 	struct nvme_iod *iod = ctx;
 	struct bio *bio = iod->private;
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	u16 status = cqe ? le16_to_cpup(&cqe->status) >> 1 : -EIO;
 
 	if (iod->nents) {
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
@@ -856,8 +884,10 @@ static void sync_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct sync_cmd_info *cmdinfo = ctx;
-	cmdinfo->result = le32_to_cpup(&cqe->result);
-	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	if (cqe) {
+		cmdinfo->result = le32_to_cpup(&cqe->result);
+		cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	}
 	wake_up_process(cmdinfo->task);
 }
 
@@ -895,12 +925,32 @@ int nvme_submit_sync_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 	return cmdinfo.status;
 }
 
+int nvme_submit_async_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
+						struct async_cmd_info *cmdinfo,
+						unsigned timeout)
+{
+	int cmdid = alloc_cmdid_killable(nvmeq, cmdinfo, async_completion,
+								timeout);
+	cmdinfo->status = -EINTR;
+	if (cmdid < 0)
+		return cmdid;
+	cmd->common.command_id = cmdid;
+	nvme_submit_cmd(nvmeq, cmd);
+	return 0;
+}
+
 int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 								u32 *result)
 {
 	return nvme_submit_sync_cmd(dev->queues[0], cmd, result, ADMIN_TIMEOUT);
 }
 
+int nvme_submit_admin_cmd_async(struct nvme_dev *dev, struct nvme_command *cmd,
+						struct async_cmd_info *cmdinfo)
+{
+	return nvme_submit_async_cmd(dev->queues[0], cmd, cmdinfo, ADMIN_TIMEOUT);
+}
+
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	int status;
@@ -1072,22 +1122,19 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 	for_each_set_bit(cmdid, nvmeq->cmdid_data, depth) {
 		void *ctx;
 		nvme_completion_fn fn;
-		static struct nvme_completion cqe = {
-			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
-		};
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
 		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
 			continue;
-		if (timeout && nvmeq->dev->is_initialised) {
+		if (timeout && nvmeq->dev->is_initialised == NVME_INITIALISED) {
 			nvme_abort_cmd(cmdid, nvmeq);
 			continue;
 		}
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
 								nvmeq->qid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
-		fn(nvmeq->dev, ctx, &cqe);
+		fn(nvmeq->dev, ctx, NULL);
 	}
 }
 
@@ -1118,6 +1165,49 @@ static void nvme_free_queues(struct nvme_dev *dev)
 	}
 }
 
+struct nvme_delq_ctx {
+	struct task_struct *worker_task;
+	struct task_struct *waiter;
+	struct kthread_worker *worker;
+	atomic_t refcount;
+};
+
+static struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
+{
+	atomic_inc(&dq->refcount);
+	return dq;
+}
+
+static void nvme_wait_dq(struct nvme_delq_ctx *dq)
+{
+	dq->waiter = current;
+	mb();
+
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!atomic_read(&dq->refcount))
+			break;
+		io_schedule();
+	}
+	set_current_state(TASK_RUNNING);
+	kthread_stop(dq->worker_task);
+}
+
+static struct nvme_delq_ctx *nvme_init_dq(struct nvme_dev *dev,
+						struct kthread_worker *worker)
+{
+	struct nvme_delq_ctx *dq;
+
+	dq = kzalloc(sizeof(*dq), GFP_KERNEL);
+	if (!dq)
+		return NULL;
+
+	dq->worker = worker;
+	dq->worker_task = kthread_run(kthread_worker_fn, worker, "nvme%d",
+							dev->instance);
+	return dq;
+}
+
 static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
@@ -1146,6 +1236,104 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
+static void nvme_put_dq(struct nvme_delq_ctx *dq)
+{
+	if (!atomic_dec_return(&dq->refcount) && dq->waiter)
+		wake_up_process(dq->waiter);
+}
+
+static void nvme_del_queue_end(struct nvme_queue *nvmeq)
+{
+	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
+
+	nvme_put_dq(dq);
+
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	nvme_cancel_ios(nvmeq, false);
+	spin_unlock_irq(&nvmeq->q_lock);
+}
+
+static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
+						kthread_work_func_t fn)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.delete_queue.opcode = opcode;
+	c.delete_queue.qid = cpu_to_le16(nvmeq->qid);
+
+	init_kthread_work(&nvmeq->cmdinfo.work, fn);
+	return nvme_submit_admin_cmd_async(nvmeq->dev, &c, &nvmeq->cmdinfo);
+}
+
+static void nvme_del_cq_work_handler(struct kthread_work *work)
+{
+	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
+							cmdinfo.work);
+	nvme_del_queue_end(nvmeq);
+}
+
+static int nvme_delete_cq(struct nvme_queue *nvmeq)
+{
+	return adapter_async_del_queue(nvmeq, nvme_admin_delete_cq,
+						nvme_del_cq_work_handler);
+}
+
+static void nvme_del_sq_work_handler(struct kthread_work *work)
+{
+	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
+							cmdinfo.work);
+	int status = nvmeq->cmdinfo.status;
+
+	if (!status)
+		status = nvme_delete_cq(nvmeq);
+	if (status)
+		nvme_del_queue_end(nvmeq);
+}
+
+static int nvme_delete_sq(struct nvme_queue *nvmeq)
+{
+	return adapter_async_del_queue(nvmeq, nvme_admin_delete_sq,
+						nvme_del_sq_work_handler);
+}
+
+static void nvme_disable_queue_async(struct nvme_dev *dev, int qid,
+						struct nvme_delq_ctx *dq)
+{
+	struct nvme_queue *nvmeq = dev->queues[qid];
+	int vector = dev->entry[nvmeq->cq_vector].vector;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	if (nvmeq->q_suspended) {
+		spin_unlock_irq(&nvmeq->q_lock);
+		return;
+	}
+	nvmeq->q_suspended = 1;
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	irq_set_affinity_hint(vector, NULL);
+	free_irq(vector, nvmeq);
+
+	nvmeq->cmdinfo.ctx = nvme_get_dq(dq);
+	nvmeq->cmdinfo.worker = dq->worker;
+	if (nvme_delete_sq(nvmeq))
+		nvme_del_queue_end(nvmeq);
+}
+
+static void nvme_disable_io_queues(struct nvme_dev *dev)
+{
+	int i;
+	struct nvme_delq_ctx *dq;
+	DEFINE_KTHREAD_WORKER_ONSTACK(worker); 
+
+	dq = nvme_init_dq(dev, &worker);
+	for (i = dev->queue_count - 1; i > 0; i--)
+		nvme_disable_queue_async(dev, i, dq);
+	nvme_wait_dq(dq);
+	kfree(dq);
+}
+
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth, int vector)
 {
@@ -1666,7 +1854,7 @@ static int nvme_kthread(void *data)
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
 			if (readl(&dev->bar->csts) & NVME_CSTS_CFS) {
-				if (dev->is_initialised) {
+				if (dev->is_initialised == NVME_INITIALISED) {
 					dev_warn(&dev->pci_dev->dev,
 						"failed status, reset controller\n");
 					list_del_init(&dev->node);
@@ -2062,11 +2250,8 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
-	int i;
-
-	dev->is_initialised = 0;
-	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_disable_queue(dev, i);
+	dev->is_initialised = NVME_UNINITIALISED;
+	nvme_disable_io_queues(dev);
 
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
@@ -2074,6 +2259,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	if (dev->bar)
 		nvme_shutdown_ctrl(dev);
+	nvme_disable_queue(dev, 0);
 	nvme_dev_unmap(dev);
 }
 
@@ -2222,7 +2408,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 
 static int nvme_dev_resume(struct nvme_dev *dev)
 {
-	int i, ret = nvme_dev_start(dev);
+	int ret = nvme_dev_start(dev);
 
 	if (ret && ret != -EBUSY) {
 		dev_warn(&dev->pci_dev->dev, "controller failed to resume\n");
@@ -2234,15 +2420,11 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		 * Device enabled but unable to perform IO; free IO queues and
 		 * block devices.
 		 */
-		for (i = dev->queue_count - 1; i > 0; i--) {
-			nvme_free_queue(dev->queues[i]);
-			dev->queue_count--;
-			dev->queues[i] = NULL;
-		}
+		nvme_free_queues(dev);
 		nvme_dev_remove(dev);
 	}
 
-	dev->is_initialised = 1;
+	dev->is_initialised = NVME_INITIALISED;
 	return 0;
 }
 
@@ -2308,7 +2490,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto remove;
 
 	kref_init(&dev->kref);
-	dev->is_initialised = 1;
+	dev->is_initialised = NVME_INITIALISED;
 	return 0;
 
  remove:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4306c5e..a1ad920 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -68,6 +68,12 @@ enum {
 
 #define NVME_IO_TIMEOUT	(5 * HZ)
 
+enum {
+	NVME_UNINITIALISED,
+	NVME_INITIALISED,
+	NVME_DEAD,
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
-- 
1.7.10.4
