From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:36 +0100
Subject: [PATCH 1/8] nvme: move set_queue_count to common code
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-2-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 19 +------------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3600a0c..a63a71a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -334,6 +334,23 @@ int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
 	return error;
 }
 
+int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count)
+{
+	int status;
+	u32 result;
+	u32 q_count = (count - 1) | ((count - 1) << 16);
+
+	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, 0,
+			&result);
+	if (status < 0)
+		return status;
+	if (status > 0) {
+		dev_err(ctrl->dev, "Could not set queue count (%d)\n", status);
+		return 0;
+	}
+	return min(result & 0xffff, result >> 16) + 1;
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d72bbe0..1692fda 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -227,6 +227,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 			dma_addr_t dma_addr, u32 *result);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 			dma_addr_t dma_addr, u32 *result);
+int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count);
 
 extern spinlock_t dev_list_lock;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2ef408f..89d2442 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1464,23 +1464,6 @@ static void nvme_create_io_queues(struct nvme_dev *dev)
 		}
 }
 
-static int set_queue_count(struct nvme_dev *dev, int count)
-{
-	int status;
-	u32 result;
-	u32 q_count = (count - 1) | ((count - 1) << 16);
-
-	status = nvme_set_features(&dev->ctrl, NVME_FEAT_NUM_QUEUES, q_count, 0,
-								&result);
-	if (status < 0)
-		return status;
-	if (status > 0) {
-		dev_err(dev->dev, "Could not set queue count (%d)\n", status);
-		return 0;
-	}
-	return min(result & 0xffff, result >> 16) + 1;
-}
-
 static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 {
 	u64 szu, size, offset;
@@ -1545,7 +1528,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	int result, i, vecs, nr_io_queues, size;
 
 	nr_io_queues = num_possible_cpus();
-	result = set_queue_count(dev, nr_io_queues);
+	result = nvme_set_queue_count(&dev->ctrl, nr_io_queues);
 	if (result <= 0)
 		return result;
 	if (result < nr_io_queues)
-- 
1.9.1
