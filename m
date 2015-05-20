From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 19 May 2015 20:20:16 -0600
Subject: [PATCH] NVMe: IRQ vector sharing depends on resources
Message-ID: <1432088416-10409-1-git-send-email-jonathan.derrick@intel.com>

If the number of io queues + admin queue is less than or equal
to the number of vectors, no IRQs will be shared. If there are more
io queues + admin queue than there are vectors, qid 0 (admin queue)
and qid 1 will share a vector

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
May improve IRQ coalescing capabilities
 drivers/block/nvme-core.c | 17 ++++++++++++-----
 include/linux/nvme.h      |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e23be20..a2e06eb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1457,7 +1457,8 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = qid - dev->shared_vec;
+
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
@@ -2265,11 +2266,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (!pdev->irq)
 		pci_disable_msix(pdev);
 
-	for (i = 0; i < nr_io_queues; i++)
+	for (i = 0; i <= nr_io_queues; i++)
 		dev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
+	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues + 1);
+
 	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues, 32));
+		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues + 1, 32));
 		if (vecs < 0) {
 			vecs = 1;
 		} else {
@@ -2278,6 +2280,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		}
 	}
 
+	if (vecs < nr_io_queues + 1)
+		dev->shared_vec = 1;
+
 	/*
 	 * Should investigate if there's a performance win from allocating
 	 * more queues than interrupt vectors; it might allow the submission
@@ -2285,6 +2290,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * number of interrupts.
 	 */
 	nr_io_queues = vecs;
+	if (!dev->shared_vec)
+		--nr_io_queues;
 	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, adminq, adminq->irqname);
@@ -2971,7 +2978,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return -ENOMEM;
-	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev->entry),
+	dev->entry = kzalloc_node((num_possible_cpus() + 1) * sizeof(*dev->entry),
 							GFP_KERNEL, node);
 	if (!dev->entry)
 		goto free;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0adad4a..e5386e1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -85,6 +85,7 @@ struct nvme_dev {
 	u32 db_stride;
 	u32 ctrl_config;
 	struct msix_entry *entry;
+	int shared_vec;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
 	struct kref kref;
-- 
2.1.4
