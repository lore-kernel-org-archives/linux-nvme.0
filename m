From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:32 -0600
Subject: [PATCHv2 8/8] nvme-pci: Unquiesce queues on dead controller
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180522220332.9244-9-keith.busch@intel.com>

This patch ensures the nvme namsepace request queues are not quiesced
on a surprise removal. It's possible the queues were previously killed
in a failed reset, so the queues need to be unquiesced to ensure all
requests are flushed to completion. This is accomplished by setting the
nvme_dev_disable 'shutdown' parameter to true, indicating we're not
going to restart the controller.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 84eeac683322..452d2199b767 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2638,7 +2638,7 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, true);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.14.3
