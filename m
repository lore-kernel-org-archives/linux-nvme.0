From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jan 2018 16:15:31 +0900
Subject: [PATCH] nvme: free pre-allocated queue if create ioq goes wrong
Message-ID: <1515914131-12725-1-git-send-email-minwoo.im.dev@gmail.com>

If either create-sq or create-cq is failed with an NVMe status,
nvme_init_queue() is invoked which was not expected to be called in
nvme_create_queue().
To prevent this inconsistency of queue_count, free queue(s) already
allocated in nvme_create_io_queues() when it goes wrong in
nvme_create_queue().

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e..a58282d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,11 +1456,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
-	if (result < 0)
-		return result;
+	if (result)
+		goto free_queue;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
-	if (result < 0)
+	if (result)
 		goto release_cq;
 
 	nvme_init_queue(nvmeq, qid);
@@ -1474,9 +1474,10 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	adapter_delete_sq(dev, qid);
  release_cq:
 	adapter_delete_cq(dev, qid);
+ free_queue:
+	nvme_free_queues(dev, dev->online_queues);
 	return result;
 }
-
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
-- 
2.7.4
