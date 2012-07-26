From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Jul 2012 16:21:08 -0600
Subject: [PATCH] NVMe: Do not set queue depth beyond device max
Message-ID: <1343341268-24613-1-git-send-email-keith.busch@intel.com>

Set the depth to the device maximum if the requested depth exceeds the
device's capabilities.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    8 ++++++--
 include/linux/nvme.h |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 7bcd882..40c751d 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -892,8 +892,12 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth, int vector)
 {
 	struct device *dmadev = &dev->pci_dev->dev;
-	unsigned extra = (depth / 8) + (depth * sizeof(struct nvme_cmd_info));
-	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq) + extra, GFP_KERNEL);
+	unsigned extra;
+	struct nvme_queue *nvmeq;
+
+	depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1, depth);
+	extra = DIV_ROUND_UP(depth, 8) + (depth * sizeof(struct nvme_cmd_info));
+	nvmeq = kzalloc(sizeof(*nvmeq) + extra, GFP_KERNEL);
 	if (!nvmeq)
 		return NULL;
 
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
