From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Tue, 27 Feb 2018 16:46:17 +0800
Subject: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
Message-ID: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>

Currently, adminq and ioq0 share the same irq vector. This is
unfair for both amdinq and ioq0.
 - For adminq, its completion irq has to be bound on cpu0.
 - For ioq0, when the irq fires for io completion, the adminq irq
   action has to be checked also.

To improve this, allocate separate irq vectors for adminq and
ioq0, and not set irq affinity for adminq one.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73036d2..7f421b7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,7 +1456,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	}
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = qid;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
@@ -1909,6 +1909,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
+	struct irq_affinity affd = {.pre_vectors = 1};
+	int ret;
 
 	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1945,11 +1947,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
+	dev->max_qid = ret - 1;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
-- 
2.7.4
