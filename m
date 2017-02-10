From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Feb 2017 18:15:53 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
Message-ID: <1486768553-13738-6-git-send-email-keith.busch@intel.com>

If the nvme driver is shutting down, it will not start the queues back
up until asked to resume. If the block layer has entered requests and
gets a CPU hot plug event prior to the resume event, it will wait for
those requests to exit. Those requests will never exit since the NVMe
driver is quieced, creating a deadlock.

This patch fixes that by freezing the queue and flushing all entered
requests to either their natural completion, or forces their demise. We
only need to do this when requesting to shutdown the controller since
we will not be starting the IO queues back up again.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c302270..1888451 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2125,6 +2125,39 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
+void nvme_unfreeze(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_unfreeze_queue(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_unfreeze);
+
+void nvme_wait_freeze(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_freeze_queue(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_wait_freeze);
+
+void nvme_start_freeze(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_freeze_queue_start(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_start_freeze);
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 569cba1..7408373 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -289,6 +289,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
+void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_wait_freeze(struct nvme_ctrl *ctrl);
+void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 92010fd..b6451d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1672,12 +1672,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i, queues;
 	u32 csts = -1;
+	bool drain_queue = pci_is_enabled(to_pci_dev(dev->dev));
 
 	del_timer_sync(&dev->watchdog_timer);
 	cancel_work_sync(&dev->reset_work);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(to_pci_dev(dev->dev))) {
+	if (drain_queue) {
+		if (shutdown)
+			nvme_start_freeze(&dev->ctrl);
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
@@ -1701,6 +1704,25 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+
+	/*
+	 * If shutting down, the driver will not be starting up queues again,
+	 * so must drain all entered requests to their demise to avoid
+	 * deadlocking blk-mq hot-cpu notifier.
+	 */
+	if (drain_queue && shutdown) {
+		nvme_start_queues(&dev->ctrl);
+		/*
+		 * Waiting for frozen increases the freeze depth. Since we
+		 * already start the freeze earlier in this function to stop
+		 * incoming requests, we have to unfreeze after froze to get
+		 * the depth back to the desired.
+		 */
+		nvme_wait_freeze(&dev->ctrl);
+		nvme_unfreeze(&dev->ctrl);
+		nvme_stop_queues(&dev->ctrl);
+	}
+
 	mutex_unlock(&dev->shutdown_lock);
 }
 
@@ -1817,6 +1839,16 @@ static void nvme_reset_work(struct work_struct *work)
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_dev_add(dev);
+
+		/*
+		 * If we are resuming from suspend, the queue was set to freeze
+		 * to prevent blk-mq's hot CPU notifier from getting stuck on
+		 * requests that entered the queue that NVMe had quiesced. Now
+		 * that we are resuming and have notified blk-mq of the new h/w
+		 * context queue count, it is safe to unfreeze the queues.
+		 */
+		if (was_suspend)
+			nvme_unfreeze(&dev->ctrl);
 	}
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
-- 
1.8.3.1
