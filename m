From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:20:00 +0100
Subject: [PATCH 20/47] nvme: add a common helper to read Identify Controller
 data
In-Reply-To: <1448090427-18749-1-git-send-email-hch@lst.de>
References: <1448090427-18749-1-git-send-email-hch@lst.de>
Message-ID: <1448090427-18749-21-git-send-email-hch@lst.de>

And add the 64-bit register read operation for it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  | 53 ++++++++++++++----------------------------------
 3 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b858df6..6ee05b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -670,6 +670,58 @@ const struct block_device_operations nvme_fops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+/*
+ * Initialize the cached copies of the Identify data and various controller
+ * register in our nvme_ctrl structure.  This should be called as soon as
+ * the admin queue is fully up and running.
+ */
+int nvme_init_identify(struct nvme_ctrl *ctrl)
+{
+	struct nvme_id_ctrl *id;
+	u64 cap;
+	int ret, page_shift;
+
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
+	if (ret) {
+		dev_err(ctrl->dev, "Reading CAP failed (%d)\n", ret);
+		return ret;
+	}
+	page_shift = NVME_CAP_MPSMIN(cap) + 12;
+
+	ret = nvme_identify_ctrl(ctrl, &id);
+	if (ret) {
+		dev_err(ctrl->dev, "Identify Controller failed (%d)\n", ret);
+		return -EIO;
+	}
+
+	ctrl->oncs = le16_to_cpup(&id->oncs);
+	ctrl->abort_limit = id->acl + 1;
+	ctrl->vwc = id->vwc;
+	memcpy(ctrl->serial, id->sn, sizeof(id->sn));
+	memcpy(ctrl->model, id->mn, sizeof(id->mn));
+	memcpy(ctrl->firmware_rev, id->fr, sizeof(id->fr));
+	if (id->mdts)
+		ctrl->max_hw_sectors = 1 << (id->mdts + page_shift - 9);
+	else
+		ctrl->max_hw_sectors = UINT_MAX;
+
+	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) && id->vs[3]) {
+		unsigned int max_hw_sectors;
+
+		ctrl->stripe_size = 1 << (id->vs[3] + page_shift);
+		max_hw_sectors = ctrl->stripe_size >> (page_shift - 9);
+		if (ctrl->max_hw_sectors) {
+			ctrl->max_hw_sectors = min(max_hw_sectors,
+							ctrl->max_hw_sectors);
+		} else {
+			ctrl->max_hw_sectors = max_hw_sectors;
+		}
+	}
+
+	kfree(id);
+	return 0;
+}
+
 static void nvme_free_ctrl(struct kref *kref)
 {
 	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9838a92..2d68262 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -55,6 +55,8 @@ struct nvme_ctrl {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
+	u32 max_hw_sectors;
+	u32 stripe_size;
 	u16 oncs;
 	u16 abort_limit;
 	u8 event_limit;
@@ -86,6 +88,7 @@ struct nvme_ns {
 
 struct nvme_ctrl_ops {
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
+	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 };
 
@@ -167,6 +170,7 @@ static inline int nvme_error_status(u16 status)
 }
 
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
+int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_put_ns(struct nvme_ns *ns);
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 03a0b3e..7e04a32 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -129,8 +129,6 @@ struct nvme_dev {
 	struct work_struct probe_work;
 	struct work_struct scan_work;
 	bool subsystem;
-	u32 max_hw_sectors;
-	u32 stripe_size;
 	u32 page_size;
 	void __iomem *cmb;
 	dma_addr_t cmb_dma_addr;
@@ -1681,13 +1679,13 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	list_add_tail(&ns->list, &dev->namespaces);
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
-	if (dev->max_hw_sectors) {
-		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
+	if (dev->ctrl.max_hw_sectors) {
+		blk_queue_max_hw_sectors(ns->queue, dev->ctrl.max_hw_sectors);
 		blk_queue_max_segments(ns->queue,
-			(dev->max_hw_sectors / (dev->page_size >> 9)) + 1);
+			(dev->ctrl.max_hw_sectors / (dev->page_size >> 9)) + 1);
 	}
-	if (dev->stripe_size)
-		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
+	if (dev->ctrl.stripe_size)
+		blk_queue_chunk_sectors(ns->queue, dev->ctrl.stripe_size >> 9);
 	if (dev->ctrl.vwc & NVME_CTRL_VWC_PRESENT)
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 	blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
@@ -2022,38 +2020,10 @@ static void nvme_dev_scan(struct work_struct *work)
 static int nvme_dev_add(struct nvme_dev *dev)
 {
 	int res;
-	struct nvme_id_ctrl *ctrl;
-	int shift = NVME_CAP_MPSMIN(lo_hi_readq(dev->bar + NVME_REG_CAP)) + 12;
-
-	res = nvme_identify_ctrl(&dev->ctrl, &ctrl);
-	if (res) {
-		dev_err(dev->dev, "Identify Controller failed (%d)\n", res);
-		return -EIO;
-	}
-
-	dev->ctrl.oncs = le16_to_cpup(&ctrl->oncs);
-	dev->ctrl.abort_limit = ctrl->acl + 1;
-	dev->ctrl.vwc = ctrl->vwc;
-	memcpy(dev->ctrl.serial, ctrl->sn, sizeof(ctrl->sn));
-	memcpy(dev->ctrl.model, ctrl->mn, sizeof(ctrl->mn));
-	memcpy(dev->ctrl.firmware_rev, ctrl->fr, sizeof(ctrl->fr));
-	if (ctrl->mdts)
-		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	else
-		dev->max_hw_sectors = UINT_MAX;
-
-	if ((dev->ctrl.quirks & NVME_QUIRK_STRIPE_SIZE) && ctrl->vs[3]) {
-		unsigned int max_hw_sectors;
 
-		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
-		max_hw_sectors = dev->stripe_size >> (shift - 9);
-		if (dev->max_hw_sectors) {
-			dev->max_hw_sectors = min(max_hw_sectors,
-							dev->max_hw_sectors);
-		} else
-			dev->max_hw_sectors = max_hw_sectors;
-	}
-	kfree(ctrl);
+	res = nvme_init_identify(&dev->ctrl);
+	if (res)
+		return res;
 
 	if (!dev->tagset.tags) {
 		dev->tagset.ops = &nvme_mq_ops;
@@ -2676,8 +2646,15 @@ static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	return 0;
 }
 
+static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+{
+	*val = readq(to_nvme_dev(ctrl)->bar + off);
+	return 0;
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read32		= nvme_pci_reg_read32,
+	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 };
 
-- 
1.9.1
