From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed, 28 Feb 2018 23:48:41 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and ioq0
Message-ID: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>

Currently, adminq and ioq0 share the same irq vector. This is
unfair for both amdinq and ioq0.
 - For adminq, its completion irq has to be bound on cpu0. It
   just has only one hw queue, it is unreasonable to do this.
 - For ioq0, when the irq fires for io completion, the adminq irq
   action on this irq vector will introduce an uncached access on
   adminq cqe at least, even worse when adminq is busy.

To improve this, allocate separate irq vectors for adminq and
ioq0, and not set irq affinity for adminq one. If just one irq
vector, setup adminq + 1 ioq and let them share it. In addition
add new helper interface nvme_ioq_vector to get ioq vector.

V1->V2
 - add case to handle the scenario where there is only one irq
   vector
 - add nvme_ioq_vector to map ioq vector and qid

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73036d2..273b157 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -84,6 +84,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
 	unsigned max_qid;
+	unsigned int num_vecs;
 	int q_depth;
 	u32 db_stride;
 	void __iomem *bar;
@@ -139,6 +140,17 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
+static inline unsigned int nvme_ioq_vector(struct nvme_dev *dev,
+		unsigned int qid)
+{
+	/*
+	 * If controller has only legacy or single-message MSI, there will
+	 * be only 1 irq vector. At the moment, we setup adminq + 1 ioq
+	 * and let them share irq vector.
+	 */
+	return (dev->num_vecs == 1) ? 0 : qid;
+}
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -1456,7 +1468,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	}
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = nvme_ioq_vector(dev, qid);
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
@@ -1626,9 +1638,9 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
-		/* vector == qid - 1, match nvme_create_queue */
 		if (nvme_alloc_queue(dev, i, dev->q_depth,
-		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
+		     pci_irq_get_node(to_pci_dev(dev->dev),
+				 nvme_ioq_vector(dev, i)))) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -1909,6 +1921,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
+	struct irq_affinity affd = {.pre_vectors = 1};
+	int ret;
 
 	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1945,12 +1959,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
-			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	if (ret <= 0)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
-
+	dev->num_vecs = ret;
+	dev->max_qid = (ret > 1) ? (ret - 1) : 1;
 	/*
 	 * Should investigate if there's a performance win from allocating
 	 * more queues than interrupt vectors; it might allow the submission
-- 
2.7.4
