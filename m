From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 Feb 2018 12:56:04 -0700
Subject: [PATCH] nvme-pci: Remap CMB SQ entries on every controller reset
Message-ID: <20180213195604.22601-1-keith.busch@intel.com>

The controller memory buffer is remapped into a kernel address on each
reset, but the driver was setting the submission queue base address
only on the very first queue creation. The remapped address is likely to
change after a reset, so accessing the old address will hit a kernel bug.

This patch will set a CMB SQ base address each time the
queue is created rather.

Fixes: f63572dff1421 ("nvme: unmap CMB and remove sysfs file in reset path")
Cc: Jon Derrick <jonathan.derrick at intel.com>
Cc: <stable at vger.kernel.org> # 4.9+
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af00a1f4..e0f5153cd6ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1364,18 +1364,14 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				int qid, int depth)
 {
-	if (qid && dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
-		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
-						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
-	} else {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
-		if (!nvmeq->sq_cmds)
-			return -ENOMEM;
-	}
+	/* CMB SQEs will be mapped before creation */
+	if (qid && dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS))
+		return 0;
 
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+					    &nvmeq->sq_dma_addr, GFP_KERNEL);
+	if (!nvmeq->sq_cmds)
+		return -ENOMEM;
 	return 0;
 }
 
@@ -1449,6 +1445,13 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
+	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
+		unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
+						      dev->ctrl.page_size);
+		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
+		nvmeq->sq_cmds_io = dev->cmb + offset;
+	}
+
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-- 
2.14.3
