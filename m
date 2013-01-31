From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Jan 2013 14:40:38 -0700
Subject: [PATCH] NVMe: Add namespaces with no LBA range feature
Message-ID: <1359668438-3915-1-git-send-email-keith.busch@intel.com>

The LBA Range Type feature is optional in the NVMe specification,
so we should continue with adding namespaces for controllers that do
not implement this feature.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 993c014..e209ec5 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1540,7 +1540,7 @@ static int __devinit nvme_dev_add(struct nvme_dev *dev)
 		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
 							dma_addr + 4096, NULL);
 		if (res)
-			continue;
+			memset(mem + 4096, 0, 4096);
 
 		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
 		if (ns)
-- 
1.7.0.4
