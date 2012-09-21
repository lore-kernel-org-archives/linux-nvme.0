From: keith.busch@intel.com (Keith Busch)
Date: Fri, 21 Sep 2012 10:52:13 -0600
Subject: [PATCH] NVMe: Add result to nvme_get_features
Message-ID: <1348246333-17669-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..bcf9275 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -840,8 +840,8 @@ static int nvme_identify(struct nvme_dev *dev, unsigned nsid, unsigned cns,
 	return nvme_submit_admin_cmd(dev, &c, NULL);
 }
 
-static int nvme_get_features(struct nvme_dev *dev, unsigned fid,
-				unsigned nsid, dma_addr_t dma_addr)
+static int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
+					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
 
@@ -851,7 +851,7 @@ static int nvme_get_features(struct nvme_dev *dev, unsigned fid,
 	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 
-	return nvme_submit_admin_cmd(dev, &c, NULL);
+	return nvme_submit_admin_cmd(dev, &c, result);
 }
 
 static int nvme_set_features(struct nvme_dev *dev, unsigned fid,
@@ -1528,7 +1528,7 @@ static int __devinit nvme_dev_add(struct nvme_dev *dev)
 			continue;
 
 		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
-							dma_addr + 4096);
+							dma_addr + 4096, NULL);
 		if (res)
 			continue;
 
-- 
1.7.0.4
