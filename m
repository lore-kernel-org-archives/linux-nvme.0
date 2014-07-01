From: daniel.mcleran@intel.com (Dan McLeran)
Date: Tue,  1 Jul 2014 09:51:54 -0600
Subject: [PATCH] NVMe: Write CC before calling enable.
Message-ID: <1404229914-6776-1-git-send-email-daniel.mcleran@intel.com>

Write the controller configuration register to configure queue sizes,
memory page size, etc. from within nvme_configure_admin_queue before
calling nvme_enable_ctrl.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..58281d2 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1512,6 +1512,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	writel(aqa, &dev->bar->aqa);
 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
+	writel(dev->ctrl_config, &dev->bar->cc);
 
 	result = nvme_enable_ctrl(dev, cap);
 	if (result)
-- 
1.7.10.4
