From: keith.busch@intel.com (Keith Busch)
Date: Tue,  2 Apr 2013 14:31:35 -0600
Subject: [PATCH] NVMe: Do not save result for range type feature
Message-ID: <1364934695-24351-1-git-send-email-keith.busch@intel.com>

The LBA range type feature being optional, we do not want to save
the result or propagate it up the call stack when a device does not
support it.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a89f7db..00819d7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1544,9 +1544,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (id_ns->ncap == 0)
 			continue;
 
-		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
-							dma_addr + 4096, NULL);
-		if (res)
+		if (nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
+							dma_addr + 4096, NULL))
 			memset(mem + 4096, 0, 4096);
 
 		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
-- 
1.7.1
