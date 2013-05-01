From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 May 2013 13:07:47 -0600
Subject: [PATCH] NVMe: Fix error clean-up on nvme_alloc_queue
Message-ID: <1367435271-15784-1-git-send-email-keith.busch@intel.com>

The nvme_queue's depth is not set if we fail to allocate submission queue
entries, which was being used to determine how much coherent memory to
free on error. Use the depth variable instead.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 40908a0..e78faf1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -956,7 +956,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	return nvmeq;
 
  free_cqdma:
-	dma_free_coherent(dmadev, CQ_SIZE(nvmeq->q_depth), (void *)nvmeq->cqes,
+	dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
 							nvmeq->cq_dma_addr);
  free_nvmeq:
 	kfree(nvmeq);
-- 
1.7.0.4
