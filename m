From: ming.lei@redhat.com (Ming Lei)
Date: Thu,  3 Jan 2019 09:34:39 +0800
Subject: [PATCH] nvme pci: fix nvme_setup_irqs()
Message-ID: <20190103013439.26700-1-ming.lei@redhat.com>

When -ENOSPC is returned from pci_alloc_irq_vectors_affinity(),
we still try to allocate multiple irq vectors again, so irq queues
covers the admin queue actually. But we don't consider that, then
number of the allocated irq vector may be same with sum of
io_queues[HCTX_TYPE_DEFAULT] and io_queues[HCTX_TYPE_READ], this way
is obviously wrong, and finally breaks nvme_pci_map_queues(), and
warning from pci_irq_get_affinity() is triggered.

IRQ queues should cover admin queues, this patch makes this
point explicitely in nvme_calc_io_queues().

We got severl boot failure internal report on aarch64, so please
consider to fix it in v4.20.

Fixes: 6451fe73fa0f ("nvme: fix irq vs io_queue calculations")
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a24d50..584ea7a57122 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2028,14 +2028,18 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
+/* irq_queues covers admin queue */
 static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 {
 	unsigned int this_w_queues = write_queues;
 
+	WARN_ON(!irq_queues);
+
 	/*
-	 * Setup read/write queue split
+	 * Setup read/write queue split, assign admin queue one independent
+	 * irq vector if irq_queues is > 1.
 	 */
-	if (irq_queues == 1) {
+	if (irq_queues <= 2) {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
 		return;
@@ -2043,21 +2047,21 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
-	 * one read queue
+	 * one read queue and one admin queue
 	 */
 	if (this_w_queues >= irq_queues)
-		this_w_queues = irq_queues - 1;
+		this_w_queues = irq_queues - 2;
 
 	/*
 	 * If 'write_queues' is set to zero, reads and writes will share
 	 * a queue set.
 	 */
 	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
 	} else {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
+		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
 	}
 }
 
@@ -2082,7 +2086,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		this_p_queues = nr_io_queues - 1;
 		irq_queues = 1;
 	} else {
-		irq_queues = nr_io_queues - this_p_queues;
+		irq_queues = nr_io_queues - this_p_queues + 1;
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
@@ -2102,8 +2106,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		 * If we got a failure and we're down to asking for just
 		 * 1 + 1 queues, just ask for a single vector. We'll share
 		 * that between the single IO queue and the admin queue.
+		 * Otherwise, we assign one independent vector to admin queue.
 		 */
-		if (result >= 0 && irq_queues > 1)
+		if (irq_queues > 1)
 			irq_queues = irq_sets[0] + irq_sets[1] + 1;
 
 		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-- 
2.9.5
