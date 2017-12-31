From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 31 Dec 2017 14:01:19 +0200
Subject: [PATCH v2] nvme-pci: don't open-code nvme_reset_ctrl
Message-ID: <20171231120119.30066-1-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- removed the WARN_ON statement

 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f30f782cb37..3f7bf21d8d1e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2487,10 +2487,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	queue_work(nvme_wq, &dev->ctrl.reset_work);
+	nvme_reset_ctrl(&dev->ctrl);
+
 	return 0;
 
  release_pools:
-- 
2.14.1
