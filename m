From: keith.busch@intel.com (Keith Busch)
Date: Fri, 31 Jul 2015 16:03:59 -0600
Subject: [PATCH] NVMe: Add device id to vendor specific chunk size
Message-ID: <1438380239-29643-1-git-send-email-keith.busch@intel.com>

A controller with a new device id supports the same striping feature
currently used with DID 0953h, so appending the new device identifier
to the check that enables this feature.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7e9dd11..8f936f3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2347,6 +2347,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	unsigned nn;
 	struct nvme_id_ctrl *ctrl;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+	u16 did = pdev->device;
 
 	res = nvme_identify_ctrl(dev, &ctrl);
 	if (res) {
@@ -2364,7 +2365,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
 	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
-			(pdev->device == 0x0953) && ctrl->vs[3]) {
+			(did == 0x0953 || did == 0x0a54) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
 
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
-- 
1.7.10.4
