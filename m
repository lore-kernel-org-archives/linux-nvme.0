From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 11:17:25 -0700
Subject: [PATCH for-4.5 08/13] NVMe: Poll device while still active during
 remove
In-Reply-To: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455128250-5984-9-git-send-email-keith.busch@intel.com>

A device failure or link down wouldn't have been detected during namespace
removal. This patch keeps the device in the list for polling so that the
thread may see such failure and initiate a reset. The device is removed
from the list after disable, so we can safely flush the reset work as
it can't be requeued when disable completes.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8bb781..0303936 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2116,16 +2116,12 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	spin_unlock(&dev_list_lock);
-
 	pci_set_drvdata(pdev, NULL);
-	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	flush_work(&dev->reset_work);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
-- 
2.6.2.307.g37023ba
