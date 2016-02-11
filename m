From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 16:00:25 -0700
Subject: [PATCH 1/2] NVMe: Lock out shutdown during pci init
Message-ID: <1455231626-7166-1-git-send-email-keith.busch@intel.com>

An unexpected driver unbind needs to be prevented from unmapping the
pci nvme registers while they're being initialized.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1b0e447..24a7972 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1927,13 +1927,19 @@ static void nvme_reset_work(struct work_struct *work)
 
 	set_bit(NVME_CTRL_RESETTING, &dev->flags);
 
+	/*
+	 * Lock out shutdown so an unexpected driver removal won't unmap
+	 * registers while reset work is setting them up.
+	 */
+	mutex_lock(&dev->shutdown_lock);
 	result = nvme_dev_map(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	result = nvme_configure_admin_queue(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
+	mutex_unlock(&dev->shutdown_lock);
 
 	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
@@ -1970,6 +1976,8 @@ static void nvme_reset_work(struct work_struct *work)
 	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
 	return;
 
+ out_unlock:
+	mutex_unlock(&dev->shutdown_lock);
  out:
 	nvme_remove_dead_ctrl(dev, result);
 }
-- 
2.6.2.307.g37023ba
