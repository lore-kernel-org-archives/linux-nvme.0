From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Apr 2014 11:41:28 -0600
Subject: [PATCHv2 1/2] NVMe: Configure support for block flush
Message-ID: <1398793289-23150-1-git-send-email-keith.busch@intel.com>

This configures an nvme request_queue as flush capable if the device
has a volatile write cache present.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

Merge up with latest tree (would not apply before).

Configure flush capable only if the device has a present volatile
write cache.

 drivers/block/nvme-core.c |    3 +++
 include/linux/nvme.h      |    1 +
 include/uapi/linux/nvme.h |    1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index efa9c8f..1d8b67d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1895,6 +1895,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
+	if (dev->vwc & NVME_VWC_PRESENT)
+		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 
 	disk->major = nvme_major;
 	disk->first_minor = 0;
@@ -2208,6 +2210,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
+	dev->vwc = ctrl->vwc;
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b95431d..3eb8875 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -102,6 +102,7 @@ struct nvme_dev {
 	u32 stripe_size;
 	u16 oncs;
 	u16 abort_limit;
+	u8 vwc;
 	u8 initialized;
 };
 
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 096fe1c..3bd0504 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -77,6 +77,7 @@ enum {
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
+	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 };
 
 struct nvme_lbaf {
-- 
1.7.10.4
