From: keith.busch@intel.com (Keith Busch)
Date: Fri,  6 May 2016 11:15:49 -0600
Subject: [PATCH] NVMe: Delete only created queues
Message-ID: <1462554949-14699-1-git-send-email-keith.busch@intel.com>

Use the online queue count instead of the number of allocated queues. The
controller should just return an invalid queue identifier error to the
commands if a queue wasn't created. While it's not harmful, it's still
not correct.

Reported-by: Saar Gross <saar at annapurnalabs.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..4e480a1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1625,12 +1625,12 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
-	int pass;
+	int pass, queues = dev->online_queues - 1;
 	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
 	for (pass = 0; pass < 2; pass++) {
-		int sent = 0, i = dev->queue_count - 1;
+		int sent = 0, i = queues;
 
 		reinit_completion(&dev->ioq_wait);
  retry:
-- 
2.7.2
