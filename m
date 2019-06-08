From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat,  8 Jun 2019 13:16:32 -0700
Subject: [PATCH] nvme-pci: code cleanup
Message-ID: <20190608201632.8244-1-chaitanya.kulkarni@wdc.com>

This is purely code cleanup patch and doesn't change any functionality.

This patch removes the extra parameter which is added to the
nvme_remove_dead_ctrl() for only printing purpose. Also the dev_warn()
line has more than 80 char.

We move the print message to the same function where actually error is
occurring and use this opportunity to fix the 80 char.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index aca5867d2e6a..cdb41a3aa048 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2466,10 +2466,8 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	kfree(dev);
 }
 
-static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
+static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
-	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
-
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	nvme_kill_queues(&dev->ctrl);
@@ -2596,7 +2594,11 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
-	nvme_remove_dead_ctrl(dev, result);
+	if (result)
+		dev_warn(dev->ctrl.device,
+				"Removing after probe failure status: %d\n",
+				result);
+	nvme_remove_dead_ctrl(dev);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
-- 
2.17.0
