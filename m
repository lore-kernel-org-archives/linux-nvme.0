From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 22 Feb 2017 10:15:07 -0700
Subject: [PATCH 2/3] nvme/pci: re-check security protocol support after reset
In-Reply-To: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
References: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1487783708-16285-3-git-send-email-scott.bauer@intel.com>

A device may change capabilities after each reset, e.g. due to a firmware
upgrade.  We should thus check for Security Send/Receive and OPAL support
after each reset.

Based on patches from Christoph and Keith.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ddc51ad..f660fc2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1739,7 +1739,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
-	kfree(dev->ctrl.opal_dev);
+	free_opal_dev(dev->ctrl.opal_dev);
 	kfree(dev);
 }
 
@@ -1789,14 +1789,17 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
-		dev->ctrl.opal_dev =
-			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
+		if (!dev->ctrl.opal_dev)
+			dev->ctrl.opal_dev =
+				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+		else if (was_suspend)
+			opal_unlock_from_suspend(dev->ctrl.opal_dev);
+	} else {
+		free_opal_dev(dev->ctrl.opal_dev);
+		dev->ctrl.opal_dev = NULL;
 	}
 
-	if (was_suspend)
-		opal_unlock_from_suspend(dev->ctrl.opal_dev);
-
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-- 
2.7.4
