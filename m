From: keith.busch@intel.com (Keith Busch)
Date: Wed,  4 Jan 2017 17:41:08 -0500
Subject: [PATCH 3/6] nvme/pci: Start queues after tagset is updated
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
Message-ID: <1483569671-1462-4-git-send-email-keith.busch@intel.com>

We need to leave the block queues stopped if we're changing the tagset's
number of queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 19beeb7..a94fbcb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1813,8 +1813,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
-		nvme_start_queues(&dev->ctrl);
 		nvme_dev_add(dev);
+		nvme_start_queues(&dev->ctrl);
 	}
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
-- 
2.5.5
