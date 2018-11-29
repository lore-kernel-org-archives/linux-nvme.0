From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Nov 2018 20:13:00 +0100
Subject: [PATCH 03/13] nvme-pci: cleanup SQ allocation a bit
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
Message-ID: <20181129191310.9795-4-hch@lst.de>

Use a bit flag to mark if the SQ was allocated from the CMB, and clean
up the surrounding code a bit.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 022395a319f4..b820dd0351cb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -186,7 +186,6 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
-	bool sq_cmds_is_io;
 	spinlock_t cq_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
@@ -203,6 +202,7 @@ struct nvme_queue {
 	u8 cq_phase;
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
+#define NVMEQ_SQ_CMB		1
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -1366,17 +1366,15 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
+	if (!nvmeq->sq_cmds)
+		return;
 
-	if (nvmeq->sq_cmds) {
-		if (nvmeq->sq_cmds_is_io)
-			pci_free_p2pmem(to_pci_dev(nvmeq->q_dmadev),
-					nvmeq->sq_cmds,
-					SQ_SIZE(nvmeq->q_depth));
-		else
-			dma_free_coherent(nvmeq->q_dmadev,
-					  SQ_SIZE(nvmeq->q_depth),
-					  nvmeq->sq_cmds,
-					  nvmeq->sq_dma_addr);
+	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
+		pci_free_p2pmem(to_pci_dev(nvmeq->q_dmadev),
+				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
+	} else {
+		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
+				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
 }
 
@@ -1462,15 +1460,14 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
 		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
 						nvmeq->sq_cmds);
-		nvmeq->sq_cmds_is_io = true;
-	}
-
-	if (!nvmeq->sq_cmds) {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
-		nvmeq->sq_cmds_is_io = false;
+		if (nvmeq->sq_dma_addr) {
+			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
+			return 0; 
+		}
 	}
 
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+				&nvmeq->sq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		return -ENOMEM;
 	return 0;
-- 
2.19.1
