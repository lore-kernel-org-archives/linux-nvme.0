From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Jul 2012 09:34:04 -0600
Subject: [PATCH] NVMe: Do not set IO queue depth beyond device max
Message-ID: <1343403244-21334-1-git-send-email-keith.busch@intel.com>

Set the depth for IO queues to the device's maximum supported queue
entries if the requested depth exceeds the device's capabilities.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   10 ++++++----
 include/linux/nvme.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 7bcd882..8006006 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -892,7 +892,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth, int vector)
 {
 	struct device *dmadev = &dev->pci_dev->dev;
-	unsigned extra = (depth / 8) + (depth * sizeof(struct nvme_cmd_info));
+	unsigned extra = DIV_ROUND_UP(depth, 8) + (depth * sizeof(
+							struct nvme_cmd_info));
 	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq) + extra, GFP_KERNEL);
 	if (!nvmeq)
 		return NULL;
@@ -1388,7 +1389,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 
 static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	int result, cpu, i, nr_io_queues, db_bar_size;
+	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1434,9 +1435,10 @@ static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 		cpu = cpumask_next(cpu, cpu_online_mask);
 	}
 
+	q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
+								NVME_Q_DEPTH);
 	for (i = 0; i < nr_io_queues; i++) {
-		dev->queues[i + 1] = nvme_create_queue(dev, i + 1,
-							NVME_Q_DEPTH, i);
+		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
 		if (IS_ERR(dev->queues[i + 1]))
 			return PTR_ERR(dev->queues[i + 1]);
 		dev->queue_count++;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9490a00..bddc954 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -35,6 +35,7 @@ struct nvme_bar {
 	__u64			acq;	/* Admin CQ Base Address */
 };
 
+#define NVME_CAP_MQES(cap)	(cap & 0xffff)
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 
-- 
1.7.0.4
