From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Jan 2018 09:16:19 -0700
Subject: [PATCH] nvme/pci: Fix queue double allocations
Message-ID: <20180123161619.31372-1-keith.busch@intel.com>

The queue count says the highest queue that's been allocated, so don't
reallocate a queue lower than that.

Fixes: 147b27e4bd0 ("nvme-pci: allocate device queues storage space at probe")
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2ffb557b616..c46c239cc1ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1384,6 +1384,9 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid,
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
 
+	if (dev->ctrl.queue_count > qid)
+		return 0;
+
 	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
 					  &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
-- 
2.13.6
