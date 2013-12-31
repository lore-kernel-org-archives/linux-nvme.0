From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 Dec 2013 15:15:18 -0700
Subject: [PATCH] NVMe: use-after-free on surprise removal fixes
Message-ID: <1388528118-4866-1-git-send-email-keith.busch@intel.com>

A surprise removal of a device while a program has an open reference to
the block handle may cause it to use the nvme dev, namespace, or queue
after we've freed them. Reference count the opens on the block device,
do not free the namespaces until the device ref count is 0, and protect
queue access with RCU.

A simple test that shows the problem, start IO, keeping an open
reference and continuing on error:

 # dd if=/dev/nvme0n1 of=/dev/null iflag=direct conv=noerror &

Then (logically) 'surprise' remove the device:

 # echo 1 > /sys/bus/pci/drivers/nvme/<domain:bus:dev.fn>/remove

Even though the request queue is "dying" and we've deleted the gendisk,
we still get new requests from the block layer. This introduces several
opprotunities of using our internal pointers after we've freed them.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This is inspired by ideas from the recent patch set from Santosh Y:

http://merlin.infradead.org/pipermail/linux-nvme/2013-December/000603.html

 drivers/block/nvme-core.c |   87 +++++++++++++++++++++++++++------------------
 include/linux/nvme.h      |    2 +-
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b59a93a..d71fc27 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -263,12 +263,12 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 
 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-	return dev->queues[get_cpu() + 1];
+	return rcu_dereference(dev->queues[part_stat_lock() + 1]);
 }
 
 void put_nvmeq(struct nvme_queue *nvmeq)
 {
-	put_cpu();
+	part_stat_unlock();
 }
 
 /**
@@ -818,9 +818,9 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
 	int result = -EBUSY;
 
-	if (!nvmeq) {
+	if (unlikely(!nvmeq)) {
 		put_nvmeq(NULL);
-		bio_endio(bio, -EIO);
+		bio_endio(bio, -ENXIO);
 		return;
 	}
 
@@ -1155,10 +1155,20 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
 	int i;
 
+	for (i = num_possible_cpus(); i > dev->queue_count - 1; i--)
+		rcu_assign_pointer(dev->queues[i], NULL);
 	for (i = dev->queue_count - 1; i >= lowest; i--) {
-		nvme_free_queue(dev->queues[i]);
+		struct nvme_queue *nvmeq = dev->queues[i];
+
+		spin_lock_irq(&nvmeq->q_lock);
+		nvme_cancel_ios(nvmeq, false);
+		spin_unlock_irq(&nvmeq->q_lock);
+
+		rcu_assign_pointer(dev->queues[i], NULL);
+		synchronize_rcu();
+
+		nvme_free_queue(nvmeq);
 		dev->queue_count--;
-		dev->queues[i] = NULL;
 	}
 }
 
@@ -1712,10 +1722,31 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif
 
+static int nvme_open(struct block_device *bdev, fmode_t mode)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_dev *dev = ns->dev;
+
+	kref_get(&dev->kref);
+	return 0;
+}
+
+static void nvme_free_dev(struct kref *kref);
+
+static void nvme_release(struct gendisk *disk, fmode_t mode)
+{
+	struct nvme_ns *ns = disk->private_data;
+	struct nvme_dev *dev = ns->dev;
+
+	kref_put(&dev->kref, nvme_free_dev);
+}
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
+	.open		= nvme_open,
+	.release	= nvme_release,
 };
 
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
@@ -1757,8 +1788,11 @@ static int nvme_kthread(void *data)
 				queue_work(nvme_workq, &dev->reset_work);
 				continue;
 			}
+
+			rcu_read_lock();	
 			for (i = 0; i < dev->queue_count; i++) {
-				struct nvme_queue *nvmeq = dev->queues[i];
+				struct nvme_queue *nvmeq =
+						rcu_dereference(dev->queues[i]);
 				if (!nvmeq)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
@@ -1770,6 +1804,7 @@ static int nvme_kthread(void *data)
  unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
+			rcu_read_unlock();
 		}
 		spin_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
@@ -1942,19 +1977,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	/* Free previously allocated queues that are no longer usable */
-	spin_lock(&dev_list_lock);
-	for (i = dev->queue_count - 1; i > nr_io_queues; i--) {
-		struct nvme_queue *nvmeq = dev->queues[i];
-
-		spin_lock_irq(&nvmeq->q_lock);
-		nvme_cancel_ios(nvmeq, false);
-		spin_unlock_irq(&nvmeq->q_lock);
-
-		nvme_free_queue(nvmeq);
-		dev->queue_count--;
-		dev->queues[i] = NULL;
-	}
-	spin_unlock(&dev_list_lock);
+	nvme_free_queues(dev, nr_io_queues + 1);
 
 	cpu = cpumask_first(cpu_online_mask);
 	for (i = 0; i < nr_io_queues; i++) {
@@ -2281,12 +2304,10 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
-	struct nvme_ns *ns, *next;
+	struct nvme_ns *ns;
 
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
+	list_for_each_entry(ns, &dev->namespaces, list) {
 		del_gendisk(ns->disk);
-		nvme_ns_free(ns);
 	}
 }
 
@@ -2346,6 +2367,12 @@ static void nvme_release_instance(struct nvme_dev *dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
+	struct nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		list_del(&ns->list);
+		nvme_ns_free(ns);
+	}
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2431,18 +2458,10 @@ static int nvme_remove_dead_ctrl(void *arg)
 
 static void nvme_remove_disks(struct work_struct *ws)
 {
-	int i;
 	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
 
 	nvme_dev_remove(dev);
-	spin_lock(&dev_list_lock);
-	for (i = dev->queue_count - 1; i > 0; i--) {
-		BUG_ON(!dev->queues[i] || !dev->queues[i]->q_suspended);
-		nvme_free_queue(dev->queues[i]);
-		dev->queue_count--;
-		dev->queues[i] = NULL;
-	}
-	spin_unlock(&dev_list_lock);
+	nvme_free_queues(dev, 1);
 }
 
 static int nvme_dev_resume(struct nvme_dev *dev)
@@ -2518,6 +2537,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
+	kref_init(&dev->kref);
 	result = nvme_dev_add(dev);
 	if (result)
 		goto shutdown;
@@ -2533,7 +2553,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto remove;
 
 	dev->initialized = 1;
-	kref_init(&dev->kref);
 	return 0;
 
  remove:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 69ae03f..98d367b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -73,7 +73,7 @@ enum {
  */
 struct nvme_dev {
 	struct list_head node;
-	struct nvme_queue **queues;
+	struct nvme_queue __rcu **queues;
 	u32 __iomem *dbs;
 	struct pci_dev *pci_dev;
 	struct dma_pool *prp_page_pool;
-- 
1.7.10.4
