From: keith.busch@intel.com (Keith Busch)
Date: Fri,  5 Oct 2018 09:09:27 -0600
Subject: [PATCHv2] nvme/pci: Fix hot removal during error handling
Message-ID: <20181005150927.24120-1-keith.busch@intel.com>

A removal waits for the reset_work to complete. If a surprise removal
occurs around the same time as an error triggered controller reset,
and reset work happened to dispatch a command to the removed controller,
the command won't be recovered since the timeout work doesn't do
anything during error recovery.

This patch fixes this by removing the admin queue prior to syncing reset.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---

v1 -> v2:

  This is simpler than the previous version. We only need to move
  syncing with the work after the admin queue has been successfully
  removed.

 drivers/nvme/host/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..9d8b0c49f8f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2564,16 +2564,15 @@ static void nvme_remove(struct pci_dev *pdev)
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-
-	cancel_work_sync(&dev->ctrl.reset_work);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
+		nvme_dev_remove_admin(dev);
 	}
 
-	flush_work(&dev->ctrl.reset_work);
+	cancel_work_sync(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.14.4
