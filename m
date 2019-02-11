From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Feb 2019 09:23:50 -0700
Subject: [PATCH] nvme-pci: Add missing unlock for reset error
Message-ID: <20190211162350.4662-1-keith.busch@intel.com>

The reset work holds a mutex to prevent races with removal modifying the
same resources, but was unlocking only on success. Unlock on failure
too.

Fixes: 5c959d73dba64 ("nvme-pci: fix rapid add remove sequence")
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
My mistake. :(

 drivers/nvme/host/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 022ea1ee63f8..7fee665ec45e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2560,15 +2560,15 @@ static void nvme_reset_work(struct work_struct *work)
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	/*
 	 * Limit the max command size to prevent iod->sg allocations going
@@ -2651,6 +2651,8 @@ static void nvme_reset_work(struct work_struct *work)
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
+ out_unlock:
+	mutex_unlock(&dev->shutdown_lock);
  out:
 	nvme_remove_dead_ctrl(dev, result);
 }
-- 
2.14.4
