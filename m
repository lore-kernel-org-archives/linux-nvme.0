From: keith.busch@intel.com (Keith Busch)
Date: Tue, 15 Nov 2016 15:56:26 -0500
Subject: [PATCH] nvme/pci: Don't free queues on error
Message-ID: <1479243386-4383-1-git-send-email-keith.busch@intel.com>

The nvme_remove function tears down all allocated resources in the correct
order, so no need to free queues on error during initialization. This
fixes possible use-after-free errors when queues are still associated
with a blk-mq hctx.

Reported-by: Scott Bauer <scott.bauer at intel.com>
Tested-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0248d0e..5e52034 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1242,20 +1242,16 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	result = nvme_enable_ctrl(&dev->ctrl, cap);
 	if (result)
-		goto free_nvmeq;
+		return result;
 
 	nvmeq->cq_vector = 0;
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
-		goto free_nvmeq;
+		return result;
 	}
 
 	return result;
-
- free_nvmeq:
-	nvme_free_queues(dev, 0);
-	return result;
 }
 
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
@@ -1317,10 +1313,8 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	max = min(dev->max_qid, dev->queue_count - 1);
 	for (i = dev->online_queues; i <= max; i++) {
 		ret = nvme_create_queue(dev->queues[i], i);
-		if (ret) {
-			nvme_free_queues(dev, i);
+		if (ret)
 			break;
-		}
 	}
 
 	/*
@@ -1460,13 +1454,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	result = queue_request_irq(adminq);
 	if (result) {
 		adminq->cq_vector = -1;
-		goto free_queues;
+		return result;
 	}
 	return nvme_create_io_queues(dev);
-
- free_queues:
-	nvme_free_queues(dev, 1);
-	return result;
 }
 
 static void nvme_del_queue_end(struct request *req, int error)
-- 
2.7.2
