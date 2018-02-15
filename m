From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu, 15 Feb 2018 19:13:41 +0800
Subject: [PATCH V2] nvme-pci: set cq_vector to -1 if io queue setup fails
Message-ID: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>

nvme cq irq is freed based on queue_count. When the sq/cq creation
fails, irq will not be setup. free_irq will warn 'Try to free
already-free irq'.

To fix it, set the nvmeq->cq_vector to -1, then nvme_suspend_queue
will ignore it.

Change log:
V1 -> V2
 - Follow Keith's suggestion, just set cq_vector to -1 if io queue setup
   fails.
 - Change patch name and comment

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4a7c420..f4528ef 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1452,7 +1452,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-		return result;
+		goto clean_cq_vector;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
@@ -1461,14 +1461,17 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
-		goto release_sq;
+		goto offline;
 
 	return result;
 
- release_sq:
+offline:
+	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
- release_cq:
+release_cq:
 	adapter_delete_cq(dev, qid);
+clean_cq_vector:
+	nvmeq->cq_vector = -1;
 	return result;
 }
 
-- 
2.7.4
