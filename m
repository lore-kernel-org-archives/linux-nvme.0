From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 May 2015 13:30:22 -0600
Subject: [PATCH 3/4] NVMe: Automatic namespace rescan
In-Reply-To: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
Message-ID: <1431977423-31587-4-git-send-email-keith.busch@intel.com>

This has the driver rescan the device for namespace changes after each
device reset or namespace change asynchronous event. Namespaces may be
dynamically allocated and deleted or attached and detached. There could
potentially be many of these that we don't want polluting /dev/ with
unusable block handles, so this will delete the disks if the namespace
is not active as indicated by the response from identify namespace. This
will it also skip adding the disk if no capacity is assigned to the
namespace in the first place.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  158 +++++++++++++++++++++++++++++++++------------
 include/linux/nvme.h      |    1 +
 include/uapi/linux/nvme.h |    4 ++
 3 files changed, 123 insertions(+), 40 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index bd36d34..767ea54 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -300,9 +300,16 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 
 	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
 		++nvmeq->dev->event_limit;
-	if (status == NVME_SC_SUCCESS)
-		dev_warn(nvmeq->q_dmadev,
-			"async event result %08x\n", result);
+	if (status != NVME_SC_SUCCESS)
+		return;
+
+	switch (result & 0xff07) {
+	case NVME_AER_NOTICE_NS_CHANGED:
+		dev_info(nvmeq->q_dmadev, "rescanning\n");
+		schedule_work(&nvmeq->dev->scan_work);
+	default:
+		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
+	}
 }
 
 static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
@@ -1990,11 +1997,14 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return 0;
 	}
 	if (nvme_identify(dev, ns->ns_id, 0, dma_addr)) {
-		dev_warn(&dev->pci_dev->dev,
-			"identify failed ns:%d, setting capacity to 0\n",
-			ns->ns_id);
+		dev_warn(&dev->pci_dev->dev, "identify failed ns:%d\n",
+								ns->ns_id);
 		memset(id, 0, sizeof(*id));
 	}
+	if (id->ncap == 0) {
+		dma_free_coherent(&dev->pci_dev->dev, 4096, id, dma_addr);
+		return -ENODEV;
+	}
 
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
@@ -2027,7 +2037,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 								!ns->ext)
 		nvme_init_integrity(ns);
 
-	if (id->ncap == 0 || (ns->ms && !blk_get_integrity(disk)))
+	if (ns->ms && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
@@ -2135,18 +2145,17 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	disk->flags = GENHD_FL_EXT_DEVT;
 	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
 
-	/*
-	 * Initialize capacity to 0 until we establish the namespace format and
-	 * setup integrity extentions if necessary. The revalidate_disk after
-	 * add_disk allows the driver to register with integrity if the format
-	 * requires it.
-	 */
-	set_capacity(disk, 0);
-	nvme_revalidate_disk(ns->disk);
+	if (nvme_revalidate_disk(ns->disk))
+		goto out_free_disk;
+
 	add_disk(ns->disk);
 	if (ns->ms)
 		revalidate_disk(ns->disk);
 	return;
+
+ out_free_disk:
+	kfree(disk);
+	list_del(&ns->list);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
@@ -2264,6 +2273,91 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
+static void nvme_free_namespace(struct nvme_ns *ns)
+{
+	list_del(&ns->list);
+
+	spin_lock(&dev_list_lock);
+	ns->disk->private_data = NULL;
+	spin_unlock(&dev_list_lock);
+
+	put_disk(ns->disk);
+	kfree(ns);
+}
+
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
+static inline bool nvme_io_incapable(struct nvme_dev *dev)
+{
+	return (!dev->bar || readl(&dev->bar->csts) & NVME_CSTS_CFS ||
+							dev->online_queues < 2);
+}
+
+static void nvme_ns_remove(struct nvme_ns *ns)
+{
+	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns->queue);
+
+	if (kill)
+		blk_set_queue_dying(ns->queue);
+	if (ns->disk->flags & GENHD_FL_UP) {
+		if (blk_get_integrity(ns->disk))
+			blk_integrity_unregister(ns->disk);
+		del_gendisk(ns->disk);
+	}
+	if (kill || !blk_queue_dying(ns->queue)) {
+		blk_mq_abort_requeue_list(ns->queue);
+		blk_cleanup_queue(ns->queue);
+        }
+}
+
+static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
+{
+	struct nvme_ns *ns;
+	unsigned i;
+
+	for (i = 1; i <= nn; i++) {
+		ns = nvme_find_ns(dev, i);
+		if (ns) {
+			if (revalidate_disk(ns->disk)) {
+				nvme_ns_remove(ns);
+				nvme_free_namespace(ns);
+			}
+		} else
+			nvme_alloc_ns(dev, i);
+	}
+}
+
+static void nvme_dev_scan(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
+	unsigned nn;
+	void *mem;
+	struct nvme_id_ctrl *ctrl;
+	dma_addr_t dma_addr;
+
+	if (IS_ERR_OR_NULL(dev->io_q))
+		return;
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
 /*
  * Return: error value if an error occurred setting up the queues or calling
  * Identify Device.  0 if these succeeded, even if adding some of the
@@ -2274,7 +2368,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = dev->pci_dev;
 	int res;
-	unsigned nn, i;
+	unsigned nn;
 	struct nvme_id_ctrl *ctrl;
 	void *mem;
 	dma_addr_t dma_addr;
@@ -2339,9 +2433,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		return 0;
 	}
 
-	for (i = 1; i <= nn; i++)
-		nvme_alloc_ns(dev, i);
-
+	nvme_scan_namespaces(dev, nn);
 	return 0;
 }
 
@@ -2639,17 +2731,8 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
-	list_for_each_entry(ns, &dev->namespaces, list) {
-		if (ns->disk->flags & GENHD_FL_UP) {
-			if (blk_get_integrity(ns->disk))
-				blk_integrity_unregister(ns->disk);
-			del_gendisk(ns->disk);
-		}
-		if (!blk_queue_dying(ns->queue)) {
-			blk_mq_abort_requeue_list(ns->queue);
-			blk_cleanup_queue(ns->queue);
-		}
-	}
+	list_for_each_entry(ns, &dev->namespaces, list)
+		nvme_ns_remove(ns);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2709,16 +2792,8 @@ static void nvme_free_namespaces(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
-
-		spin_lock(&dev_list_lock);
-		ns->disk->private_data = NULL;
-		spin_unlock(&dev_list_lock);
-
-		put_disk(ns->disk);
-		kfree(ns);
-	}
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
+		nvme_free_namespace(ns);
 }
 
 static void nvme_free_dev(struct kref *kref)
@@ -2903,6 +2978,7 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		spin_unlock(&dev_list_lock);
 	} else {
 		nvme_unfreeze_queues(dev);
+		schedule_work(&dev->scan_work);
 		nvme_set_irq_hints(dev);
 	}
 	return 0;
@@ -2981,6 +3057,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	get_device(dev->device);
 
 	INIT_LIST_HEAD(&dev->node);
+	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->probe_work, nvme_async_probe);
 	schedule_work(&dev->probe_work);
 	return 0;
@@ -3047,6 +3124,7 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->probe_work);
+	flush_work(&dev->scan_work);
 	flush_work(&dev->reset_work);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 013c38f..409d191 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -93,6 +93,7 @@ struct nvme_dev {
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
 	struct work_struct probe_work;
+	struct work_struct scan_work;
 	char name[12];
 	char serial[20];
 	char model[40];
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..11f9cdc 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -179,6 +179,10 @@ enum {
 	NVME_SMART_CRIT_VOLATILE_MEMORY	= 1 << 4,
 };
 
+enum {
+	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
-- 
1.7.10.4
