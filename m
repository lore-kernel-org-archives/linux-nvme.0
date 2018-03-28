From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Mar 2018 12:04:19 -0600
Subject: [PATCH] nvme-pci: Skip queue deletion if there are no queues
Message-ID: <20180328180419.16129-1-keith.busch@intel.com>

User reported controller always retains CSTS.RDY to 1, which fails
controller disabling when resetting the controller. This is also before
the admin queue is allocated, and trying to disable an unallocated queue
results in a NULL dereference.

Reported-by: Alex Gagniuc <Alex_Gagniuc at Dellteam.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cef5ce851a92..b110eac1d0e6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2200,7 +2200,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_stop_queues(&dev->ctrl);
 
-	if (!dead) {
+	if (!dead && dev->ctrl.queue_count > 0) {
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
-- 
2.14.3
