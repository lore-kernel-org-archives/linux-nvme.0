From: keith.busch@intel.com (Keith Busch)
Date: Wed,  5 Oct 2016 16:32:46 -0400
Subject: [PATCH 2/2] nvme: Delete created IO queues on reset
In-Reply-To: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
References: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
Message-ID: <1475699566-5284-2-git-send-email-keith.busch@intel.com>

Commit c21377f8 (Suspend all queues before deletion) decrements the
online queue count prior to our attempt to delete those IO queues, so
the driver ended up not having the controller delete any. This patch
uses the queue_count instead of online_queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 108d301..670f0cb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1512,7 +1512,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
-	int pass, queues = dev->online_queues - 1;
+	int pass, queues = dev->queue_count - 1;
 	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
-- 
2.7.2
