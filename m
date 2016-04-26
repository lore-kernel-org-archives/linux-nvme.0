From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Apr 2016 13:51:59 +0200
Subject: [PATCH 4/5] nvme: move namespace scanning to core
In-Reply-To: <1461671520-4758-1-git-send-email-hch@lst.de>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
Message-ID: <1461671520-4758-5-git-send-email-hch@lst.de>

Move the scan work item and surrounding code to the common code.  For now
we need a new finish_scan method to allow the PCI driver to set the
irq affinity hints, but I have plans in the works to obsolete this as well.

Note that this moves the namespace scanning from nvme_wq to the system
workqueue, but as we don't rely on namespace scanning to finish from reset
or I/O this should be fine.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  4 +++-
 drivers/nvme/host/pci.c  | 32 +++++---------------------------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c334fe4..9389df8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1518,7 +1518,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	return ret;
 }
 
-static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
+static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 {
 	struct nvme_ns *ns, *next;
 	unsigned i;
@@ -1534,11 +1534,16 @@ static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
 	}
 }
 
-void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
+static void nvme_scan_work(struct work_struct *work)
 {
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, scan_work);
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
@@ -1549,13 +1554,26 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 		if (!nvme_scan_ns_list(ctrl, nn))
 			goto done;
 	}
-	__nvme_scan_namespaces(ctrl, le32_to_cpup(&id->nn));
+	nvme_scan_ns_sequential(ctrl, nn);
  done:
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
+
+	if (ctrl->ops->post_scan)
+		ctrl->ops->post_scan(ctrl);
 }
-EXPORT_SYMBOL_GPL(nvme_scan_namespaces);
+
+void nvme_queue_scan(struct nvme_ctrl *ctrl)
+{
+	/*
+	 * Do not queue new scan work when a controller is reset during
+	 * removal.
+	 */
+	if (ctrl->state == NVME_CTRL_LIVE)
+		schedule_work(&ctrl->scan_work);
+}
+EXPORT_SYMBOL_GPL(nvme_queue_scan);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
@@ -1597,6 +1615,9 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	flush_work(&ctrl->scan_work);
+	nvme_remove_namespaces(ctrl);
+
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
@@ -1640,6 +1661,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
+	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ea9f47..980cf16 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -108,6 +108,7 @@ struct nvme_ctrl {
 	u32 vs;
 	bool subsystem;
 	unsigned long quirks;
+	struct work_struct scan_work;
 };
 
 /*
@@ -147,6 +148,7 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
+	void (*post_scan)(struct nvme_ctrl *ctrl);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
@@ -207,7 +209,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
-void nvme_scan_namespaces(struct nvme_ctrl *ctrl);
+void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f98d77f..c79ea4f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -92,7 +92,6 @@ struct nvme_dev {
 	struct msix_entry *entry;
 	void __iomem *bar;
 	struct work_struct reset_work;
-	struct work_struct scan_work;
 	struct work_struct remove_work;
 	struct work_struct async_work;
 	struct timer_list watchdog_timer;
@@ -266,16 +265,6 @@ static int nvme_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static void nvme_queue_scan(struct nvme_dev *dev)
-{
-	/*
-	 * Do not queue new scan work when a controller is reset during
-	 * removal.
-	 */
-	if (dev->ctrl.state == NVME_CTRL_LIVE)
-		queue_work(nvme_workq, &dev->scan_work);
-}
-
 static void nvme_complete_async_event(struct nvme_dev *dev,
 		struct nvme_completion *cqe)
 {
@@ -293,7 +282,7 @@ static void nvme_complete_async_event(struct nvme_dev *dev,
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(dev->ctrl.device, "rescanning\n");
-		nvme_queue_scan(dev);
+		nvme_queue_scan(&dev->ctrl);
 	default:
 		dev_warn(dev->ctrl.device, "async event result %08x\n", result);
 	}
@@ -1520,8 +1509,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_set_irq_hints(struct nvme_dev *dev)
+static void nvme_pci_post_scan(struct nvme_ctrl *ctrl)
 {
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq;
 	int i;
 
@@ -1536,16 +1526,6 @@ static void nvme_set_irq_hints(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_scan(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
-
-	if (!dev->tagset.tags)
-		return;
-	nvme_scan_namespaces(&dev->ctrl);
-	nvme_set_irq_hints(dev);
-}
-
 static void nvme_del_queue_end(struct request *req, int error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
@@ -1893,7 +1873,7 @@ static void nvme_reset_work(struct work_struct *work)
 	}
 
 	if (dev->online_queues > 1)
-		nvme_queue_scan(dev);
+		nvme_queue_scan(&dev->ctrl);
 	return;
 
  out:
@@ -1953,6 +1933,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read64		= nvme_pci_reg_read64,
 	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
+	.post_scan		= nvme_pci_post_scan,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -2004,7 +1985,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto free;
 
-	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	INIT_WORK(&dev->async_work, nvme_async_event_work);
@@ -2070,8 +2050,6 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->async_work);
-	flush_work(&dev->scan_work);
-	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	flush_work(&dev->reset_work);
-- 
2.1.4
