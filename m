From: keith.busch@intel.com (Keith Busch)
Date: Mon,  1 Jun 2015 14:28:14 -0600
Subject: [PATCHv3] NVMe: Automatic namespace rescan
Message-ID: <1433190494-19375-1-git-send-email-keith.busch@intel.com>

Namespaces may be dynamically allocated and deleted or attached and
detached. This has the driver rescan the device for namespace changes
after each device reset or namespace change asynchronous event.

There could potentially be many detached namespaces that we don't want
polluting /dev/ with unusable block handles, so this will delete disks
if the namespace is not active as indicated by the response from identify
namespace. This also skips adding the disk if no capacity is provisioned
to the namespace in the first place.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2 -> v3:

  Merged with latest linux-block/for-next.

  Single patch instead of part of a series of dubiously related
  patches. This is, however, depenedent on patch proposal to remove
  blk-mq's hctx reliance for managing nvme io queue tags here:

    http://lists.infradead.org/pipermail/linux-nvme/2015-June/001860.html

  Keeps the namespace list sorted (proposed by Matthew Wilcox).

  Removes namespaces that exceed the device's reported number of
  namespaces since this is not guaranteed to be a fixed value.

 drivers/block/nvme-core.c |  159 ++++++++++++++++++++++++++++++++++++---------
 include/linux/nvme.h      |    1 +
 include/uapi/linux/nvme.h |    4 ++
 3 files changed, 132 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 9cc3838..1a020e3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -29,6 +29,7 @@
 #include <linux/kdev_t.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
+#include <linux/list_sort.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -299,9 +300,16 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 
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
@@ -1940,8 +1948,13 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	unsigned short bs;
 
 	if (nvme_identify_ns(dev, ns->ns_id, &id)) {
-		dev_warn(dev->dev, "%s: Identify failure\n", __func__);
-		return 0;
+		dev_warn(dev->dev, "%s: Identify failure nvme%dn%d\n", __func__,
+						dev->instance, ns->ns_id);
+		return -ENODEV;
+	}
+	if (id->ncap == 0) {
+		kfree(id);
+		return -ENODEV;
 	}
 
 	old_ms = ns->ms;
@@ -1975,7 +1988,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 								!ns->ext)
 		nvme_init_integrity(ns);
 
-	if (id->ncap == 0 || (ns->ms && !blk_get_integrity(disk)))
+	if (ns->ms && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
@@ -2093,11 +2106,16 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	 * requires it.
 	 */
 	set_capacity(disk, 0);
-	nvme_revalidate_disk(ns->disk);
+	if (nvme_revalidate_disk(ns->disk))
+		goto out_free_disk;
+
 	add_disk(ns->disk);
 	if (ns->ms)
 		revalidate_disk(ns->disk);
 	return;
+ out_free_disk:
+	kfree(disk);
+	list_del(&ns->list);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
@@ -2220,6 +2238,99 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
+static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
+	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
+
+	return nsa->ns_id - nsb->ns_id;
+}
+
+static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned nsid)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		if (ns->ns_id == nsid)
+			return ns;
+		if (ns->ns_id > nsid)
+			break;
+	}
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
+	struct nvme_ns *ns, *next;
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
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		if (ns->ns_id > nn) {
+			nvme_ns_remove(ns);
+			nvme_free_namespace(ns);
+		}
+	}
+	list_sort(NULL, &dev->namespaces, ns_cmp);
+}
+
+static void nvme_dev_scan(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
+	struct nvme_id_ctrl *ctrl;
+
+	if (!dev->tagset.tags)
+		return;
+	if (nvme_identify_ctrl(dev, &ctrl))
+		return;
+	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
+	kfree(ctrl);
+}
+
 /*
  * Return: error value if an error occurred setting up the queues or calling
  * Identify Device.  0 if these succeeded, even if adding some of the
@@ -2230,7 +2341,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int res;
-	unsigned nn, i;
+	unsigned nn;
 	struct nvme_id_ctrl *ctrl;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
@@ -2276,9 +2387,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (blk_mq_alloc_tag_set(&dev->tagset))
 		return 0;
 
-	for (i = 1; i <= nn; i++)
-		nvme_alloc_ns(dev, i);
-
+	schedule_work(&dev->scan_work);
 	return 0;
 }
 
@@ -2578,17 +2687,8 @@ static void nvme_dev_remove(struct nvme_dev *dev)
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
@@ -2647,16 +2747,8 @@ static void nvme_free_namespaces(struct nvme_dev *dev)
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
@@ -2837,6 +2929,7 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		spin_unlock(&dev_list_lock);
 	} else {
 		nvme_unfreeze_queues(dev);
+		schedule_work(&dev->scan_work);
 		nvme_set_irq_hints(dev);
 	}
 	return 0;
@@ -2940,6 +3033,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto put_dev;
 
 	INIT_LIST_HEAD(&dev->node);
+	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->probe_work, nvme_async_probe);
 	schedule_work(&dev->probe_work);
 	return 0;
@@ -3012,6 +3106,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
+	flush_work(&dev->scan_work);
 	device_remove_file(dev->device, &dev_attr_reset_controller);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 77ffa04..6f70c4d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -95,6 +95,7 @@ struct nvme_dev {
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
 	struct work_struct probe_work;
+	struct work_struct scan_work;
 	char name[12];
 	char serial[20];
 	char model[40];
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 7d2907d..1620baa 100644
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
