From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Feb 2017 18:15:49 -0500
Subject: [PATCH 1/5] nvme/pci: Disable on removal when disconnected
In-Reply-To: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
Message-ID: <1486768553-13738-2-git-send-email-keith.busch@intel.com>

If the device is not present, the driver should disable the queues
immediately. Prior to this, the driver was relying on the watchdog timer
to kill the queues if requests were outstanding to the device, and that
just delays removal up to one second.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e25d632..9126637 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1997,8 +1997,10 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
-	if (!pci_device_is_present(pdev))
+	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+		nvme_dev_disable(dev, false);
+	}
 
 	flush_work(&dev->reset_work);
 	nvme_uninit_ctrl(&dev->ctrl);
-- 
1.8.3.1
