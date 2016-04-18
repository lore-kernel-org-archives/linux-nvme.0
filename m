From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Apr 2016 08:34:49 -0400
Subject: [PATCH 1/5] nvme: remove the io_incapable method
In-Reply-To: <1460982893-11315-1-git-send-email-hch@lst.de>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
Message-ID: <1460982893-11315-2-git-send-email-hch@lst.de>

It's unused since "NVMe: Move error handling to failed reset handler".

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 12 ------------
 drivers/nvme/host/pci.c  |  8 --------
 2 files changed, 20 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e8fae8..c6b32c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -136,7 +136,6 @@ struct nvme_ctrl_ops {
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
-	bool (*io_incapable)(struct nvme_ctrl *ctrl);
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 };
@@ -150,17 +149,6 @@ static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 	return val & NVME_CSTS_RDY;
 }
 
-static inline bool nvme_io_incapable(struct nvme_ctrl *ctrl)
-{
-	u32 val = 0;
-
-	if (ctrl->ops->io_incapable(ctrl))
-		return true;
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val))
-		return true;
-	return val & NVME_CSTS_CFS;
-}
-
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff3c8d7..23998c7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1941,13 +1941,6 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	return 0;
 }
 
-static bool nvme_pci_io_incapable(struct nvme_ctrl *ctrl)
-{
-	struct nvme_dev *dev = to_nvme_dev(ctrl);
-
-	return !dev->bar || dev->online_queues < 2;
-}
-
 static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	return nvme_reset(to_nvme_dev(ctrl));
@@ -1958,7 +1951,6 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-	.io_incapable		= nvme_pci_io_incapable,
 	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
 };
-- 
2.1.4
