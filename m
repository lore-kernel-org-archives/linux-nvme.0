From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Jul 2019 16:34:52 -0600
Subject: [PATCH] nvme-pci: Fix async probe remove race
Message-ID: <20190729223452.12967-1-keith.busch@intel.com>

From: Keith Busch <kbusch@kernel.org>

Ensure the controller is not in the NEW state when nvme_probe() exits.
This will always allow a subsequent nvme_remove() to set the state to
DELETING, fixing a potential race between the initial asynchronous probe
and device removal.

Reported-by: Li Zhong <lizhongfs at gmail.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Keith Busch <kbusch at kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..0c2c4b0c6655 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2695,7 +2695,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
 
-	nvme_reset_ctrl_sync(&dev->ctrl);
+	flush_work(&dev->ctrl.reset_work);
 	flush_work(&dev->ctrl.scan_work);
 	nvme_put_ctrl(&dev->ctrl);
 }
@@ -2761,6 +2761,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	nvme_reset_ctrl(&dev->ctrl);
 	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
-- 
2.14.4
