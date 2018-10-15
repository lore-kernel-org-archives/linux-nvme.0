From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Oct 2018 10:19:06 -0600
Subject: [PATCHv3] nvme/pci: Fix hot removal during error handling
Message-ID: <20181015161906.15741-1-keith.busch@intel.com>

A removal waits for the reset_work to complete. If a surprise removal
occurs around the same time as an error triggered controller reset, and
reset work happened to dispatch a command to the removed controller, the
command won't be recovered since the timeout work doesn't do anything
during error recovery. We wouldn't want to wait for timeout handling
anyway, so this patch fixes this by disabling the controller and killing
admin queues prior to syncing with the reset_work.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2->v3:
  Just keep the existing flush_work instead of replacing it with
  cancel_work_sync.

 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 450481c2fd17..72737009b82d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2564,13 +2564,12 @@ static void nvme_remove(struct pci_dev *pdev)
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
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.14.4
