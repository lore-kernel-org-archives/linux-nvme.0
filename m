From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:51:07 +0100
Subject: [PATCH 3/3] nvme-pci: refactor nvme_poll_irqdisable to make sparse
 happy
In-Reply-To: <20181213085107.17183-1-hch@lst.de>
References: <20181213085107.17183-1-hch@lst.de>
Message-ID: <20181213085107.17183-4-hch@lst.de>

By duplicating the nvme_process_cq in both branches we keep the
sparse lock context checking happy, so do it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb9d8270f32c..c0f66d2f6e80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1093,15 +1093,15 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 	 * using the CQ lock.  For normal interrupt driven threads we have
 	 * to disable the interrupt to avoid racing with it.
 	 */
-	if (nvmeq->cq_vector == -1)
+	if (nvmeq->cq_vector == -1) {
 		spin_lock(&nvmeq->cq_poll_lock);
-	else
-		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
-	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	if (nvmeq->cq_vector == -1)
+		found = nvme_process_cq(nvmeq, &start, &end, tag);
 		spin_unlock(&nvmeq->cq_poll_lock);
-	else
+	} else {
+		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+		found = nvme_process_cq(nvmeq, &start, &end, tag);
 		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	}
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
-- 
2.19.2
