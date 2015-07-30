From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Thu, 30 Jul 2015 11:23:20 +0200
Subject: [PATCH] NVMe: removed unused nn var from nvme_dev_add
Message-ID: <1438248200-3360-1-git-send-email-m@bjorling.me>

The logic in nvme_dev_add to enumerate namespaces was moved to
nvme_dev_scan. When moved, the nn variable is no longer used. This patch
removes it.

Fixes: a5768aai ("NVMe: Automatic namespace rescan")
Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/nvme-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d844ec4..82a3241 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2344,7 +2344,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int res;
-	unsigned nn;
 	struct nvme_id_ctrl *ctrl;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
@@ -2354,7 +2353,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		return -EIO;
 	}
 
-	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
-- 
2.1.4
