From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Sep 2017 13:54:39 -0400
Subject: [PATCH] nvme/pci: Initialize queue memory before interrupts
Message-ID: <1505411679-1625-1-git-send-email-keith.busch@intel.com>

A spurious interrupt before the nvme driver has initialized the completion
queue may inadvertently cause the driver to believe it has a completion
to process. This may result in a NULL dereference since the nvmeq's tags
are not set at this point.

The patch initializes the host's CQ memory so that a spurious interrupt
isn't mistaken for a real completion.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 925467b..df96562 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1310,11 +1310,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
+	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
 		goto release_sq;
 
-	nvme_init_queue(nvmeq, qid);
 	return result;
 
  release_sq:
@@ -1460,6 +1460,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 
 	nvmeq->cq_vector = 0;
+	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
@@ -2134,7 +2135,6 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
 		goto out;
-- 
2.5.5
