From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Apr 2016 13:51:57 +0200
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <1461671520-4758-1-git-send-email-hch@lst.de>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
Message-ID: <1461671520-4758-3-git-send-email-hch@lst.de>

Replace the adhoc flags in the PCI driver with a state machine in the
core code.  Based on code from Sagi Grimberg for the Fabrics driver.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h | 11 +++++++++++
 drivers/nvme/host/pci.c  | 25 ++++++++++++------------
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4eb5759..c334fe4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -58,6 +58,55 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
+		enum nvme_ctrl_state new_state)
+{
+	enum nvme_ctrl_state old_state = ctrl->state;
+	bool changed = false;
+
+	spin_lock_irq(&ctrl->lock);
+	switch (new_state) {
+	case NVME_CTRL_LIVE:
+		switch (old_state) {
+		case NVME_CTRL_RESETTING:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
+	case NVME_CTRL_RESETTING:
+		switch (old_state) {
+		case NVME_CTRL_NEW:
+		case NVME_CTRL_LIVE:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
+	case NVME_CTRL_DELETING:
+		switch (old_state) {
+		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_irq(&ctrl->lock);
+
+	if (changed)
+		ctrl->state = new_state;
+
+	return changed;
+}
+EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
+
 static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
@@ -1583,6 +1632,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 {
 	int ret;
 
+	ctrl->state = NVME_CTRL_NEW;
+	spin_lock_init(&ctrl->lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	mutex_init(&ctrl->namespaces_mutex);
 	kref_init(&ctrl->kref);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c6b32c5..2ea9f47 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -67,7 +67,16 @@ enum nvme_quirks {
 	NVME_QUIRK_DISCARD_ZEROES		= (1 << 2),
 };
 
+enum nvme_ctrl_state {
+	NVME_CTRL_NEW,
+	NVME_CTRL_LIVE,
+	NVME_CTRL_RESETTING,
+	NVME_CTRL_DELETING,
+};
+
 struct nvme_ctrl {
+	enum nvme_ctrl_state state;
+	spinlock_t lock;
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
 	struct device *dev;
@@ -187,6 +196,8 @@ static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 		(jiffies - req->start_time) < req->timeout;
 }
 
+bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
+		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 23998c7..b922608 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -102,11 +102,6 @@ struct nvme_dev {
 	dma_addr_t cmb_dma_addr;
 	u64 cmb_size;
 	u32 cmbsz;
-	unsigned long flags;
-
-#define NVME_CTRL_RESETTING    0
-#define NVME_CTRL_REMOVING     1
-
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
 };
@@ -277,9 +272,8 @@ static void nvme_queue_scan(struct nvme_dev *dev)
 	 * Do not queue new scan work when a controller is reset during
 	 * removal.
 	 */
-	if (test_bit(NVME_CTRL_REMOVING, &dev->flags))
-		return;
-	queue_work(nvme_workq, &dev->scan_work);
+	if (dev->ctrl.state != NVME_CTRL_DELETING)
+		queue_work(nvme_workq, &dev->scan_work);
 }
 
 static void nvme_complete_async_event(struct nvme_dev *dev,
@@ -901,7 +895,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * cancellation error. All outstanding requests are completed on
 	 * shutdown, so we return BLK_EH_HANDLED.
 	 */
-	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
+	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
@@ -1835,7 +1829,7 @@ static void nvme_reset_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
 	int result = -ENODEV;
 
-	if (WARN_ON(test_bit(NVME_CTRL_RESETTING, &dev->flags)))
+	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
 		goto out;
 
 	/*
@@ -1845,7 +1839,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
-	set_bit(NVME_CTRL_RESETTING, &dev->flags);
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+		goto out;
 
 	result = nvme_pci_enable(dev);
 	if (result)
@@ -1893,7 +1888,10 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dev_add(dev);
 	}
 
-	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
+		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
+		goto out;
+	}
 	return;
 
  out:
@@ -2066,7 +2064,8 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	del_timer_sync(&dev->watchdog_timer);
 
-	set_bit(NVME_CTRL_REMOVING, &dev->flags);
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->async_work);
 	flush_work(&dev->scan_work);
-- 
2.1.4
