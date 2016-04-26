From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Apr 2016 13:52:00 +0200
Subject: [PATCH 5/5] nvme: move AER handling to common code
In-Reply-To: <1461671520-4758-1-git-send-email-hch@lst.de>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
Message-ID: <1461671520-4758-6-git-send-email-hch@lst.de>

The transport driver still needs to do the actual submission, but all the
higher level code can be shared.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  | 49 +++++++++--------------------------------------
 3 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9389df8..e9f634d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1584,6 +1584,54 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
+static void nvme_async_event_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, async_event_work);
+
+	spin_lock_irq(&ctrl->lock);
+	while (ctrl->event_limit > 0) {
+		int aer_idx = --ctrl->event_limit;
+
+		spin_unlock_irq(&ctrl->lock);
+		ctrl->ops->submit_async_event(ctrl, aer_idx);
+		spin_lock_irq(&ctrl->lock);
+	}
+	spin_unlock_irq(&ctrl->lock);
+}
+
+void nvme_complete_async_event(struct nvme_ctrl *ctrl,
+		struct nvme_completion *cqe)
+{
+	u16 status = le16_to_cpu(cqe->status) >> 1;
+	u32 result = le32_to_cpu(cqe->result);
+
+	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ) {
+		++ctrl->event_limit;
+		schedule_work(&ctrl->async_event_work);
+	}
+
+	if (status != NVME_SC_SUCCESS)
+		return;
+
+	switch (result & 0xff07) {
+	case NVME_AER_NOTICE_NS_CHANGED:
+		dev_info(ctrl->device, "rescanning\n");
+		nvme_queue_scan(ctrl);
+		break;
+	default:
+		dev_warn(ctrl->device, "async event result %08x\n", result);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_complete_async_event);
+
+void nvme_queue_async_events(struct nvme_ctrl *ctrl)
+{
+	ctrl->event_limit = NVME_NR_AERS;
+	schedule_work(&ctrl->async_event_work);
+}
+EXPORT_SYMBOL_GPL(nvme_queue_async_events);
+
 static DEFINE_IDA(nvme_instance_ida);
 
 static int nvme_set_instance(struct nvme_ctrl *ctrl)
@@ -1615,6 +1663,7 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
 	nvme_remove_namespaces(ctrl);
 
@@ -1662,6 +1711,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 980cf16..2b46126 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -109,6 +109,7 @@ struct nvme_ctrl {
 	bool subsystem;
 	unsigned long quirks;
 	struct work_struct scan_work;
+	struct work_struct async_event_work;
 };
 
 /*
@@ -149,6 +150,7 @@ struct nvme_ctrl_ops {
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*post_scan)(struct nvme_ctrl *ctrl);
+	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
@@ -212,6 +214,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
+#define NVME_NR_AERS	1
+void nvme_complete_async_event(struct nvme_ctrl *ctrl,
+		struct nvme_completion *cqe);
+void nvme_queue_async_events(struct nvme_ctrl *ctrl);
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c79ea4f..ee396ea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -54,8 +54,7 @@
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
  */
-#define NVME_NR_AEN_COMMANDS	1
-#define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
+#define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
 
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
@@ -93,7 +92,6 @@ struct nvme_dev {
 	void __iomem *bar;
 	struct work_struct reset_work;
 	struct work_struct remove_work;
-	struct work_struct async_work;
 	struct timer_list watchdog_timer;
 	struct mutex shutdown_lock;
 	bool subsystem;
@@ -265,29 +263,6 @@ static int nvme_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static void nvme_complete_async_event(struct nvme_dev *dev,
-		struct nvme_completion *cqe)
-{
-	u16 status = le16_to_cpu(cqe->status) >> 1;
-	u32 result = le32_to_cpu(cqe->result);
-
-	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ) {
-		++dev->ctrl.event_limit;
-		queue_work(nvme_workq, &dev->async_work);
-	}
-
-	if (status != NVME_SC_SUCCESS)
-		return;
-
-	switch (result & 0xff07) {
-	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(dev->ctrl.device, "rescanning\n");
-		nvme_queue_scan(&dev->ctrl);
-	default:
-		dev_warn(dev->ctrl.device, "async event result %08x\n", result);
-	}
-}
-
 /**
  * __nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -709,7 +684,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		 */
 		if (unlikely(nvmeq->qid == 0 &&
 				cqe.command_id >= NVME_AQ_BLKMQ_DEPTH)) {
-			nvme_complete_async_event(nvmeq->dev, &cqe);
+			nvme_complete_async_event(&nvmeq->dev->ctrl, &cqe);
 			continue;
 		}
 
@@ -778,21 +753,18 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return 0;
 }
 
-static void nvme_async_event_work(struct work_struct *work)
+static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 {
-	struct nvme_dev *dev = container_of(work, struct nvme_dev, async_work);
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = dev->queues[0];
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
+	c.common.command_id = NVME_AQ_BLKMQ_DEPTH + aer_idx;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	while (dev->ctrl.event_limit > 0) {
-		c.common.command_id = NVME_AQ_BLKMQ_DEPTH +
-			--dev->ctrl.event_limit;
-		__nvme_submit_cmd(nvmeq, &c);
-	}
+	__nvme_submit_cmd(nvmeq, &c);
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
@@ -1848,10 +1820,8 @@ static void nvme_reset_work(struct work_struct *work)
 	 * should not submit commands the user did not request, so skip
 	 * registering for asynchronous event notification on this condition.
 	 */
-	if (dev->online_queues > 1) {
-		dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
-		queue_work(nvme_workq, &dev->async_work);
-	}
+	if (dev->online_queues > 1)
+		nvme_queue_async_events(&dev->ctrl);
 
 	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
 
@@ -1934,6 +1904,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.post_scan		= nvme_pci_post_scan,
+	.submit_async_event	= nvme_pci_submit_async_event,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -1987,7 +1958,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
-	INIT_WORK(&dev->async_work, nvme_async_event_work);
 	setup_timer(&dev->watchdog_timer, nvme_watchdog_timer,
 		(unsigned long)dev);
 	mutex_init(&dev->shutdown_lock);
@@ -2049,7 +2019,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
 	pci_set_drvdata(pdev, NULL);
-	flush_work(&dev->async_work);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	flush_work(&dev->reset_work);
-- 
2.1.4
