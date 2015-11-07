From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:38 +0100
Subject: [PATCH 3/8] nvme: move CC setup into nvme_enable_ctrl
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-4-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 7 +++++--
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/pci.c  | 7 +------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c061a6a..2254ce9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -400,9 +400,12 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	return nvme_update_ctrl_config(ctrl, cap, false);
 }
 
-int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
+int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap, unsigned page_shift)
 {
-	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config = NVME_CC_CSS_NVM;
+	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	ctrl->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
 	return nvme_update_ctrl_config(ctrl, cap, true);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 426cafc..8cf6fa5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -230,7 +230,7 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 			dma_addr_t dma_addr, u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
-int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
+int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap, unsigned page_shift);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 
 extern spinlock_t dev_list_lock;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d50a2b7..45255e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1292,16 +1292,11 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	dev->page_size = 1 << page_shift;
 
-	dev->ctrl.ctrl_config = NVME_CC_CSS_NVM;
-	dev->ctrl.ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	dev->ctrl.ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	dev->ctrl.ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
-
 	writel(aqa, dev->bar + NVME_REG_AQA);
 	writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
 	writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
 
-	result = nvme_enable_ctrl(&dev->ctrl, cap);
+	result = nvme_enable_ctrl(&dev->ctrl, cap, page_shift);
 	if (result)
 		goto free_nvmeq;
 
-- 
1.9.1
