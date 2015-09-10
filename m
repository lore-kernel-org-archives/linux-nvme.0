From: sathya.m@samsung.com (Sathyavathi M)
Date: Thu, 10 Sep 2015 16:59:04 +0530
Subject: [PATCH] Increase the max transfer size when mdts is 0
Message-ID: <1441884544-10183-1-git-send-email-sathya.m@samsung.com>

From: Sathyavathi M <sathya.m@samsung.com>

This patch address the issue when IO with 128KB from FIO is splitted as two
parts, 124KB and 4KB due to max transfer size(127KB).This degrades the device
performance.

Signed-off-by: Sathyavathi M <sathya.m at samsung.com>
---
 drivers/block/nvme-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..9bf6ea5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2479,6 +2479,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
+	else
+		dev->max_hw_sectors = UINT_MAX;
 	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
 			(pdev->device == 0x0953) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
-- 
1.9.1
