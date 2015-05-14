From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 May 2015 14:01:47 -0600
Subject: [PATCH] NVMe: Automatic namespace rescan
Message-ID: <1431633707-9265-1-git-send-email-keith.busch@intel.com>

This rescans device namespaces everytime the controller is reset,
or if the controller posts an asynchronous event indicating namespace
attributes have changed. The namespace scanning work will revalidate
existing namespaces for any attribute changes, such as block format or
capacity, as well as look for new namespaces that may be allocated or
attached to this controller.

If namespaces are deleted, this does not go so far as to delete gendisks;
instead, its capacity will be set to 0.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   66 +++++++++++++++++++++++++++++++++++++++------
 include/linux/nvme.h      |    1 +
 include/uapi/linux/nvme.h |    5 ++++
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 77aa061..f17f9af 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -307,9 +307,16 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 
 	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
 		++nvmeq->dev->event_limit;
-	if (status == NVME_SC_SUCCESS)
-		dev_warn(nvmeq->q_dmadev,
-			"async event result %08x\n", result);
+	if (status == NVME_SC_SUCCESS) {
+		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
+		if ((result & 0x3) == NVME_AER_TYPE_NOTICE &&
+		    ((result >> 8) & 0xff) == NVME_AER_INFO_NS_CHANGE) {
+			struct nvme_dev *dev = nvmeq->dev;
+			dev_info(nvmeq->q_dmadev,
+				"namespace change event, rescan\n");
+			schedule_work(&dev->scan_work);
+		}
+	}
 }
 
 static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
@@ -2162,6 +2169,50 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	kfree(ns);
 }
 
+static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned nsid)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		if (ns->ns_id == nsid)
+			return ns;
+	return NULL;
+}
+
+static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
+{
+	struct nvme_ns *ns;
+	unsigned i;
+
+	for (i = 1; i <= nn; i++) {
+		ns = nvme_find_ns(dev, i);
+		if (ns)
+			revalidate_disk(ns->disk);
+		else
+			nvme_alloc_ns(dev, i);
+	}
+}
+
+static void nvme_dev_scan(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
+	unsigned long nn;
+	void *mem;
+	struct nvme_id_ctrl *ctrl;
+	dma_addr_t dma_addr;
+
+	mem = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr, GFP_KERNEL);
+	if (!mem)
+		return;
+	if (nvme_identify(dev, 0, 1, dma_addr))
+		goto free;
+	ctrl = mem;
+	nn = le32_to_cpup(&ctrl->nn);
+	nvme_scan_namespaces(dev, nn);
+ free:
+	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
+}
+
 static void nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i;
@@ -2283,7 +2334,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = dev->pci_dev;
 	int res;
-	unsigned nn, i;
 	struct nvme_id_ctrl *ctrl;
 	void *mem;
 	dma_addr_t dma_addr;
@@ -2301,7 +2351,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	}
 
 	ctrl = mem;
-	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
@@ -2337,9 +2386,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (blk_mq_alloc_tag_set(&dev->tagset))
 		return 0;
 
-	for (i = 1; i <= nn; i++)
-		nvme_alloc_ns(dev, i);
-
+	schedule_work(&dev->scan_work);
 	return 0;
 }
 
@@ -2911,6 +2958,7 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		spin_unlock(&dev_list_lock);
 	} else {
 		nvme_unfreeze_queues(dev);
+		schedule_work(&dev->scan_work);
 		nvme_set_irq_hints(dev);
 	}
 	return 0;
@@ -2989,6 +3037,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	get_device(dev->device);
 
 	INIT_LIST_HEAD(&dev->node);
+	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->probe_work, nvme_async_probe);
 	schedule_work(&dev->probe_work);
 	return 0;
@@ -3054,6 +3103,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	spin_unlock(&dev_list_lock);
 
 	pci_set_drvdata(pdev, NULL);
+	flush_work(&dev->scan_work);
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
 	nvme_dev_remove(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8dbd05e..539e5e5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -92,6 +92,7 @@ struct nvme_dev {
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
 	struct work_struct probe_work;
+	struct work_struct scan_work;
 	char name[12];
 	char serial[20];
 	char model[40];
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..b05d481 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -179,6 +179,11 @@ enum {
 	NVME_SMART_CRIT_VOLATILE_MEMORY	= 1 << 4,
 };
 
+enum {
+	NVME_AER_TYPE_NOTICE	= 2,
+	NVME_AER_INFO_NS_CHANGE	= 0,
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
-- 
1.7.10.4
