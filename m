From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:11 -0700
Subject: [PATCH 6/8] nvme/pci: Remove q_dmadev from nvme_queue
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190308174313.5134-6-keith.busch@intel.com>

We don't need to save the dma device as it's not used in the hot path
and hasn't in a long time. Shrink the struct nvme_queue removing this
unnecessary member.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 06db19b45d2b..3481f3e3d6a1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -177,7 +177,6 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
  * commands and one for I/O commands).
  */
 struct nvme_queue {
-	struct device *q_dmadev;
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
@@ -1336,16 +1335,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
+	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (!nvmeq->sq_cmds)
 		return;
 
 	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
-		pci_free_p2pmem(to_pci_dev(nvmeq->q_dmadev),
+		pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev),
 				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
 	} else {
-		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
+		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq->q_depth),
 				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
 }
@@ -1457,7 +1456,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
 		goto free_cqdma;
 
-	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
-- 
2.14.4
