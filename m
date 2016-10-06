From: keith.busch@intel.com (Keith Busch)
Date: Thu,  6 Oct 2016 13:27:42 -0400
Subject: [PATCHv3] nvme: Delete created IO queues on reset
Message-ID: <1475774862-3285-1-git-send-email-keith.busch@intel.com>

The driver was decrementing the online_queues prior to attempting to
delete those IO queues, so the driver ended up not requesting the
controller delete any. This patch saves the online_queues prior to
suspending them, and adds that parameter for deleting io queues.

Fixes: c21377f8 ("nvme: Suspend all queues before deletion")

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2 -> v3:

  Commit message grammar fix.

v1 -> v2:

  Instead of using queue_count, this takes a snapshot of the online
  queues and makes that a parameter.

 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 108d301..cba40eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1510,9 +1510,9 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	return 0;
 }
 
-static void nvme_disable_io_queues(struct nvme_dev *dev)
+static void nvme_disable_io_queues(struct nvme_dev *dev, int queues)
 {
-	int pass, queues = dev->online_queues - 1;
+	int pass;
 	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
@@ -1648,7 +1648,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
-	int i;
+	int i, queues;
 	u32 csts = -1;
 
 	del_timer_sync(&dev->watchdog_timer);
@@ -1659,13 +1659,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
 
+	queues = dev->online_queues - 1;
 	for (i = dev->queue_count - 1; i > 0; i--)
 		nvme_suspend_queue(dev->queues[i]);
 
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
 		nvme_suspend_queue(dev->queues[0]);
 	} else {
-		nvme_disable_io_queues(dev);
+		nvme_disable_io_queues(dev, queues);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_pci_disable(dev);
-- 
2.7.2
