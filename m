From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Wed, 06 Aug 2014 18:24:38 +0530
Subject: [PATCH] NVMe: Fix partition detection issue(Hot Remove followed by Hot
 Add)
Message-ID: <060001cfb175$a1c44c00$e54ce400$@samsung.com>

This patch addresses the same issue that has been discussed at
http://lists.infradead.org/pipermail/linux-nvme/2014-August/001093.html
recently
and provides the best of both worlds (both static & dynamic minor allocation
schemes similar to SCSI driver(sd)).

- Partially reverts the dynamic minor allocation scheme (but retains the
GENHD_FL_EXT_DEVT flag to allow allocating very large of minors dynamically)

  introduced in commit 469071a37afc8a627b6b2ddf29db0a097d864845 and
re-introduces static minor allocation.
- Aligns Hot-Plug behaviour to SCSI.
- Uses one common ida allocation routine for allocating namespace & dev
instances.
- Introduces a new module parameter nvme_minors to manage the static minor
allocations(default is 64).

Signed-off-by: Indraneel M <indraneel.m at samsung.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..6d01164 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -65,6 +65,10 @@ MODULE_PARM_DESC(retry_time, "time in seconds to retry
failed I/O");
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
+static int nvme_minors = 64;
+module_param(nvme_minors, int, 0644);
+MODULE_PARM_DESC(nvme_minors, "Minors numbers to allocate per Namespace");
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -1962,12 +1966,42 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
 }
 
+static DEFINE_IDA(nvme_ns_instance_ida);
+static DEFINE_IDA(nvme_dev_instance_ida);
+
+static int nvme_get_instance(struct nvme_dev *dev, struct ida *ida)
+{
+	int instance, error;
+
+	do {
+		if (!ida_pre_get(ida, GFP_KERNEL))
+			return -ENODEV;
+
+		spin_lock(&dev_list_lock);
+		error = ida_get_new(ida, &instance);
+		spin_unlock(&dev_list_lock);
+	} while (error == -EAGAIN);
+
+	if (error)
+		instance = -ENODEV;
+
+	return instance;
+}
+
+static void nvme_put_instance(struct nvme_dev *dev, struct ida *ida, int
instance)
+{
+	spin_lock(&dev_list_lock);
+	ida_remove(ida, instance);
+	spin_unlock(&dev_list_lock);
+}
+
+
 static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 			struct nvme_id_ns *id, struct nvme_lba_range_type
*rt)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
-	int lbaf;
+	int lbaf, instance;
 
 	if (rt->attributes & NVME_LBART_ATTRIB_HIDE)
 		return NULL;
@@ -1985,7 +2019,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev
*dev, unsigned nsid,
 	ns->dev = dev;
 	ns->queue->queuedata = ns;
 
-	disk = alloc_disk(0);
+	disk = alloc_disk(nvme_minors);
 	if (!disk)
 		goto out_free_queue;
 	ns->ns_id = nsid;
@@ -2000,7 +2034,13 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev
*dev, unsigned nsid,
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 
 	disk->major = nvme_major;
-	disk->first_minor = 0;
+
+	disk->minors = nvme_minors;
+	instance = nvme_get_instance(dev, &nvme_ns_instance_ida);
+	if (instance < 0)
+		goto out_free_disk;
+	disk->first_minor = nvme_minors * instance;
+
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
@@ -2014,6 +2054,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev
*dev, unsigned nsid,
 
 	return ns;
 
+ out_free_disk:
+	put_disk(ns->disk);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
@@ -2623,42 +2665,16 @@ static void nvme_release_prp_pools(struct nvme_dev
*dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static DEFINE_IDA(nvme_instance_ida);
-
-static int nvme_set_instance(struct nvme_dev *dev)
-{
-	int instance, error;
-
-	do {
-		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
-			return -ENODEV;
-
-		spin_lock(&dev_list_lock);
-		error = ida_get_new(&nvme_instance_ida, &instance);
-		spin_unlock(&dev_list_lock);
-	} while (error == -EAGAIN);
-
-	if (error)
-		return -ENODEV;
-
-	dev->instance = instance;
-	return 0;
-}
-
-static void nvme_release_instance(struct nvme_dev *dev)
-{
-	spin_lock(&dev_list_lock);
-	ida_remove(&nvme_instance_ida, dev->instance);
-	spin_unlock(&dev_list_lock);
-}
-
 static void nvme_free_namespaces(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
+	int index;
 
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		index = ns->disk->first_minor / nvme_minors;
 		list_del(&ns->list);
 		put_disk(ns->disk);
+		nvme_put_instance(dev, &nvme_ns_instance_ida, index);
 		kfree(ns);
 	}
 }
@@ -2669,6 +2685,7 @@ static void nvme_free_dev(struct kref *kref)
 
 	nvme_free_namespaces(dev);
 	free_percpu(dev->io_queue);
+	nvme_put_instance(dev, &nvme_dev_instance_ida, dev->instance);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2844,9 +2861,10 @@ static int nvme_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 	INIT_WORK(&dev->cpu_work, nvme_cpu_workfn);
 	dev->pci_dev = pdev;
 	pci_set_drvdata(pdev, dev);
-	result = nvme_set_instance(dev);
-	if (result)
+	result = nvme_get_instance(dev, &nvme_dev_instance_ida);
+	if (result < 0)
 		goto free;
+	dev->instance = result;
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
@@ -2883,7 +2901,7 @@ static int nvme_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
  release:
-	nvme_release_instance(dev);
+	nvme_put_instance(dev, &nvme_dev_instance_ida, dev->instance);
  free:
 	free_percpu(dev->io_queue);
 	kfree(dev->queues);
@@ -2924,7 +2942,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
 	rcu_barrier();
-	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.8.3.2
