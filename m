From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 15 Jan 2018 06:00:50 +0900
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
Message-ID: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>

If either create-sq or create-cq is failed with an NVMe status,
nvme_init_queue() is invoked which was not expected to be called in
nvme_create_queue().
To prevent this inconsistency of queue_count, free queue(s) already
allocated in nvme_create_io_queues() when it goes wrong in
nvme_create_queue().

Changes to V1:
    - Move calling nvme_free_queues() to nvme_create_io_queues() instead of
      nvme_create_queue(). (Sagi)

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Sagi Grimberg <sagi at grmberg.me>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e..ecef45a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,11 +1456,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
-	if (result < 0)
+	if (result)
 		return result;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
-	if (result < 0)
+	if (result)
 		goto release_cq;
 
 	nvme_init_queue(nvmeq, qid);
@@ -1476,7 +1476,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	adapter_delete_cq(dev, qid);
 	return result;
 }
-
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
@@ -1637,8 +1636,10 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
 	for (i = dev->online_queues; i <= max; i++) {
 		ret = nvme_create_queue(dev->queues[i], i);
-		if (ret)
+		if (ret) {
+			nvme_free_queues(dev, dev->online_queues);
 			break;
+		}
 	}
 
 	/*
-- 
2.7.4
