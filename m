From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Dec 2017 15:37:17 +0200
Subject: [PATCH] nvme-pci: don't open-code nvme_reset_ctrl
Message-ID: <20171225133717.4557-1-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48c5fb864a61..77200fb89a64 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2487,10 +2487,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	queue_work(nvme_wq, &dev->ctrl.reset_work);
+	WARN_ON_ONCE(nvme_reset_ctrl(&dev->ctrl));
+
 	return 0;
 
  release_pools:
-- 
2.14.1
