From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jul 2012 16:07:10 -0600
Subject: [PATCH] NVMe: Set block queue max sectors
Message-ID: <1343254030-309-1-git-send-email-keith.busch@intel.com>

Set the max hw sectors in a namespace's request queue if the nvme device has a
max data transfer size.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    6 ++++++
 include/linux/nvme.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 38b9c73..3247037 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -78,6 +78,7 @@ struct nvme_dev {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
+	u32 max_hw_sectors;
 };
 
 /*
@@ -1345,6 +1346,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
+	if (dev->max_hw_sectors) 
+		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
 
 	disk->major = nvme_major;
 	disk->minors = NVME_MINORS;
@@ -1486,6 +1489,9 @@ static int __devinit nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
+	if (ctrl->mdts)
+		dev->max_hw_sectors = ((1 << ctrl->mdts) * (1 << (12 +
+				NVME_CAP_MPSMIN(readq(&dev->bar->cap))))) >> 9;
 
 	id_ns = mem;
 	for (i = 1; i <= nn; i++) {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9490a00..8c71d20 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -37,6 +37,7 @@ struct nvme_bar {
 
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
+#define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
-- 
1.7.0.4
