From: joe@perches.com (Joe Perches)
Date: Sun, 15 Jun 2014 13:37:33 -0700
Subject: [PATCH -next 04/26] block: Use dma_zalloc_coherent
In-Reply-To: <cover.1402863904.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
Message-ID: <ff8b612a77e9c4d5826df68b3e6fe27b800610e9.1402863905.git.joe@perches.com>

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe at perches.com>
---
 drivers/block/nvme-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a842c71..27b5d3b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1242,11 +1242,10 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	if (!nvmeq)
 		return NULL;
 
-	nvmeq->cqes = dma_alloc_coherent(dmadev, CQ_SIZE(depth),
-					&nvmeq->cq_dma_addr, GFP_KERNEL);
+	nvmeq->cqes = dma_zalloc_coherent(dmadev, CQ_SIZE(depth),
+					  &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
-	memset((void *)nvmeq->cqes, 0, CQ_SIZE(depth));
 
 	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr, GFP_KERNEL);
-- 
1.8.1.2.459.gbcd45b4.dirty
