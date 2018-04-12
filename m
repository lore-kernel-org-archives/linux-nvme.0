From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 09:16:08 -0600
Subject: [PATCH 06/13] nvme-pci: Skip queue deletion if there are no queues
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <20180412151615.5176-7-keith.busch@intel.com>

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
index 295fbec1e5f2..22403aa7dc60 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2201,7 +2201,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_stop_queues(&dev->ctrl);
 
-	if (!dead) {
+	if (!dead && dev->ctrl.queue_count > 0) {
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
-- 
2.14.3
