From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 10 Jun 2015 10:41:30 -0600
Subject: [PATCHv2] NVMe: Stripe queue IRQ vector assignments
Message-ID: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>

This patch will stripe io queue IRQ vector assignments across the
available vector resources. This also changes the current implementation
which reduces the number of io queues to the number of vectors enabled.
This fixes another issue where the admin queue and io queue 0 were
unnecessarily sharing an vector.

The benefits of this are two-fold:
a) There is a known issue in one controller where irq coalescing cannot
occur on vectors to which the admin queue is assigned. This patch assigns
the admin queue its own vector, as long as there are enough vectors
available to assign one to each io queue and the admin queue.
b) If a suitable number of vector resources cannot be acquired to match
the number of io queues, the current implementation will reduce the
number of io queues. There is a likely performance benefit to keeping
the number of io queues equal to the number of possible cpus, even if
the vectors have to be shared among the queues.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/block/nvme-core.c | 12 ++++++------
 include/linux/nvme.h      |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2072ae8..ef450b8 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1507,7 +1507,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = qid % dev->vec_count;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
@@ -2175,11 +2175,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (!pdev->irq)
 		pci_disable_msix(pdev);
 
-	for (i = 0; i < nr_io_queues; i++)
+	for (i = 0; i <= nr_io_queues; i++)
 		dev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
+	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues + 1);
 	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues, 32));
+		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues + 1, 32));
 		if (vecs < 0) {
 			vecs = 1;
 		} else {
@@ -2194,7 +2194,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * path to scale better, even if the receive path is limited by the
 	 * number of interrupts.
 	 */
-	nr_io_queues = vecs;
+	dev->vec_count = vecs;
 	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, adminq, adminq->irqname);
@@ -2990,7 +2990,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return -ENOMEM;
-	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev->entry),
+	dev->entry = kzalloc_node((num_possible_cpus() + 1) * sizeof(*dev->entry),
 							GFP_KERNEL, node);
 	if (!dev->entry)
 		goto free;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c0d94ed..a8e64aa 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -79,6 +79,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	int instance;
 	unsigned queue_count;
+	unsigned vec_count;
 	unsigned online_queues;
 	unsigned max_qid;
 	int q_depth;
-- 
2.1.4
