From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:51 -0700
Subject: [PATCH 4/7] NVMe: Clean-up character device bring-up
In-Reply-To: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
Message-ID: <1390607454-23273-5-git-send-email-keith.busch@intel.com>

... because the way for getting an nvme character device up when it the
controller is otherwise unable to create IO queues was a bit tacky.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   23 ++++++++++++-----------
 include/linux/nvme.h      |    1 +
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e9a4acc..076987e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1193,6 +1193,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
+	nvmeq->dev->online_queues--;
 	return 0;
 }
 
@@ -1287,6 +1288,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	memset(nvmeq->cmdid_data, 0, extra);
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvmeq->q_suspended = 0;
+	nvmeq->dev->online_queues++;
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
@@ -1884,7 +1886,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count, 0,
 								&result);
 	if (status)
-		return status < 0 ? -EIO : -EBUSY;
+		return status < 0 ? -EIO : 0;
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
@@ -1900,7 +1902,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
-	if (result < 0)
+	if (result <= 0)
 		return result;
 	if (result < nr_io_queues)
 		nr_io_queues = result;
@@ -2429,7 +2431,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 
 	result = nvme_setup_io_queues(dev);
-	if (result && result != -EBUSY)
+	if (result)
 		goto disable;
 
 	return result;
@@ -2468,9 +2470,9 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	int ret;
 
 	ret = nvme_dev_start(dev);
-	if (ret && ret != -EBUSY)
+	if (ret)
 		return ret;
-	if (ret == -EBUSY) {
+	if (dev->online_queues < 2) {
 		spin_lock(&dev_list_lock);
 		INIT_WORK(&dev->reset_work, nvme_remove_disks);
 		queue_work(nvme_workq, &dev->reset_work);
@@ -2530,18 +2532,17 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release;
 
 	result = nvme_dev_start(dev);
-	if (result) {
-		if (result == -EBUSY)
-			goto create_cdev;
+	if (result)
 		goto release_pools;
-	}
 
 	kref_init(&dev->kref);
-	result = nvme_dev_add(dev);
+
+	/* Don't bother adding disks if we don't have online IO queues */
+	if (dev->online_queues > 1)
+		result = nvme_dev_add(dev);
 	if (result)
 		goto shutdown;
 
- create_cdev:
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 98d367b..2fef3ce 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -80,6 +80,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	int instance;
 	int queue_count;
+	unsigned online_queues;
 	u32 db_stride;
 	u32 ctrl_config;
 	struct msix_entry *entry;
-- 
1.7.10.4
