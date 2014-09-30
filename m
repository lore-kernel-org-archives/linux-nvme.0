From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Sep 2014 18:26:14 -0600
Subject: [PATCH] NVMe: Report device's preferred IO unit
Message-ID: <1412036774-4363-1-git-send-email-keith.busch@intel.com>

This sets the queue's io_opt, which is the device's smallest preferred
request size and alignment for sustained performance. The nvme namespace's
logical block format with the relative performance set to 0 is optimal
for the device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 9aeef40..73e01d5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2031,6 +2031,14 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 
+	for (lbaf = 0; lbaf < id->nlbaf; lbaf++) {
+		u16 rp = le16_to_cpu(id->lbaf[lbaf].rp);
+		if (!rp) {
+			blk_queue_io_opt(ns->queue, 1 << id->lbaf[lbaf].ds);
+			break;
+		}
+	}
+
 	disk->major = nvme_major;
 	disk->first_minor = 0;
 	disk->fops = &nvme_fops;
-- 
1.7.10.4
