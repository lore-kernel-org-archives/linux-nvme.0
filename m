From: keith.busch@intel.com (Keith Busch)
Date: Wed, 27 Apr 2016 15:51:18 -0600
Subject: [PATCH] NVMe: Fix check_flush_dependency warning
Message-ID: <1461793878-14732-1-git-send-email-keith.busch@intel.com>

If the controller fails and is degraded after a reset, we need to kill
off all requests queues before removing the inaccessble namespaces. This
will prevent del_gendisk from syncing dirty data, which we can't due
from a WQ_MEM_RECLAIM work queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dda19cc..6d49e47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1909,6 +1909,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->online_queues < 2) {
 		dev_warn(dev->ctrl.device, "IO queues not created\n");
+		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-- 
2.7.2
