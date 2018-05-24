From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:57 -0600
Subject: [PATCHv3 6/9] nvme-pci: Unquiesce dead controller queues
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-7-keith.busch@intel.com>

This patch ensures the nvme namsepace request queues are not quiesced
on a surprise removal. It's possible the queues were previously killed
in a failed reset, so the queues need to be unquiesced to ensure all
requests are flushed to completion.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 54e22b964385..40863ed759de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2637,7 +2637,7 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, true);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.14.3
