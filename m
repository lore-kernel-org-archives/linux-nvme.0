From: ddstreet@ieee.org (Dan Streetman)
Date: Wed,  7 Dec 2016 17:03:26 -0500
Subject: [PATCH] nvme: create the correct number of queues
Message-ID: <20161207220326.8461-1-ddstreet@ieee.org>

Change nr_io_queues variable name to nr_queues, as it includes not
only the io queues but also the admin queue in its count; and change
the variable name in functions that it is passed into, for clarity.

Also correct misuses of the nr_queue count:

In the db_bar_size() function, the calculation added 1 to the
nr_io_queues value to account for the admin queue, but since that's
actually already in the nr_queue count, don't add it.

In the nvme_setup_io_queues() function when allocating irq vectors,
it considers the minimum number of queues to be 1, but actually 2
queues are needed; 1 admin queue + at least 1 io queue.

When setting the device's max_qid (maximum queue index id), it's
currently set to nr_io_queues, but since nr_queues counts all
queues, and because max_qid is 0-based and nr_queues is 1-based,
max_qid must be set to nr_queues - 1.

Signed-off-by: Dan Streetman <dan.streetman at canonical.com>
---
 drivers/nvme/host/pci.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index def2285..eff8198 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1007,15 +1007,15 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
+static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_queues,
 				int entry_size)
 {
 	int q_depth = dev->q_depth;
 	unsigned q_size_aligned = roundup(q_depth * entry_size,
 					  dev->ctrl.page_size);
 
-	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
-		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
+	if (q_size_aligned * nr_queues > dev->cmb_size) {
+		u64 mem_per_q = div_u64(dev->cmb_size, nr_queues);
 		mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
 		q_depth = div_u64(mem_per_q, entry_size);
 
@@ -1387,27 +1387,27 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	}
 }
 
-static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
+static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_queues)
 {
-	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
+	return 4096 + (nr_queues * 8 * dev->db_stride);
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, nr_io_queues, size;
+	int result, nr_queues, size;
 
-	nr_io_queues = num_online_cpus();
-	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
+	nr_queues = num_online_cpus();
+	result = nvme_set_queue_count(&dev->ctrl, &nr_queues);
 	if (result < 0)
 		return result;
 
-	if (nr_io_queues == 0)
+	if (nr_queues == 0)
 		return 0;
 
 	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
-		result = nvme_cmb_qdepth(dev, nr_io_queues,
+		result = nvme_cmb_qdepth(dev, nr_queues,
 				sizeof(struct nvme_command));
 		if (result > 0)
 			dev->q_depth = result;
@@ -1415,16 +1415,16 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 			nvme_release_cmb(dev);
 	}
 
-	size = db_bar_size(dev, nr_io_queues);
+	size = db_bar_size(dev, nr_queues);
 	if (size > 8192) {
 		iounmap(dev->bar);
 		do {
 			dev->bar = ioremap(pci_resource_start(pdev, 0), size);
 			if (dev->bar)
 				break;
-			if (!--nr_io_queues)
+			if (!--nr_queues)
 				return -ENOMEM;
-			size = db_bar_size(dev, nr_io_queues);
+			size = db_bar_size(dev, nr_queues);
 		} while (1);
 		dev->dbs = dev->bar + 4096;
 		adminq->q_db = dev->dbs;
@@ -1438,11 +1438,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
+	nr_queues = pci_alloc_irq_vectors(pdev, 1, nr_queues,
 			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	/* we need at least 1 admin queue + 1 io queue */
+	if (nr_queues < 2)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
+	dev->max_qid = nr_queues - 1;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
-- 
2.9.3
