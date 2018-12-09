From: axboe@kernel.dk (Jens Axboe)
Date: Sun, 9 Dec 2018 11:21:45 -0700
Subject: [PATCH] nvme: fix irq vs io_queue calculations
Message-ID: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>

Guenter reported an boot hang issue on HPPA after we default to 0 poll
queues. We have two issues in the queue count calculations:

1) We don't separate the poll queues from the read/write queues. This is
   important, since the former doesn't need interrupts.
2) The adjust logic is broken.

Adjust the poll queue count before doing nvme_calc_io_queues(). The poll
queue count is only limited by the IO queue count we were able to get
from the controller, not failures in the IRQ allocation loop. This
leaves nvme_calc_io_queues() just adjusting the read/write queue map.

Reported-by: Reported-by: Guenter Roeck <linux at roeck-us.net>
Signed-off-by: Jens Axboe <axboe at kernel.dk>

---

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7732c4979a4e..0fe48b128aff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2030,60 +2030,40 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
+static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 {
 	unsigned int this_w_queues = write_queues;
-	unsigned int this_p_queues = poll_queues;
 
 	/*
 	 * Setup read/write queue split
 	 */
-	if (nr_io_queues == 1) {
+	if (irq_queues == 1) {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
-		dev->io_queues[HCTX_TYPE_POLL] = 0;
 		return;
 	}
 
-	/*
-	 * Configure number of poll queues, if set
-	 */
-	if (this_p_queues) {
-		/*
-		 * We need at least one queue left. With just one queue, we'll
-		 * have a single shared read/write set.
-		 */
-		if (this_p_queues >= nr_io_queues) {
-			this_w_queues = 0;
-			this_p_queues = nr_io_queues - 1;
-		}
-
-		dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
-		nr_io_queues -= this_p_queues;
-	} else
-		dev->io_queues[HCTX_TYPE_POLL] = 0;
-
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
 	 * one read queue
 	 */
-	if (this_w_queues >= nr_io_queues)
-		this_w_queues = nr_io_queues - 1;
+	if (this_w_queues >= irq_queues)
+		this_w_queues = irq_queues - 1;
 
 	/*
 	 * If 'write_queues' is set to zero, reads and writes will share
 	 * a queue set.
 	 */
 	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
 	} else {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = nr_io_queues - this_w_queues;
+		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
 	}
 }
 
-static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
+static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int irq_sets[2];
@@ -2093,6 +2073,20 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		.sets = irq_sets,
 	};
 	int result = 0;
+	unsigned int irq_queues, this_p_queues;
+
+	/*
+	 * Poll queues don't need interrupts, but we need at least one IO
+	 * queue left over for non-polled IO.
+	 */
+	this_p_queues = poll_queues;
+	if (this_p_queues >= nr_io_queues) {
+		this_p_queues = nr_io_queues - 1;
+		irq_queues = 1;
+	} else {
+		irq_queues = nr_io_queues - this_p_queues;
+	}
+	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
 	/*
 	 * For irq sets, we have to ask for minvec == maxvec. This passes
@@ -2100,7 +2094,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 	 * IRQ vector needs.
 	 */
 	do {
-		nvme_calc_io_queues(dev, nr_io_queues);
+		nvme_calc_io_queues(dev, irq_queues);
 		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
 		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
 		if (!irq_sets[1])
@@ -2111,11 +2105,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		 * 1 + 1 queues, just ask for a single vector. We'll share
 		 * that between the single IO queue and the admin queue.
 		 */
-		if (!(result < 0 && nr_io_queues == 1))
-			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
+		if (!(result < 0 || irq_queues == 1))
+			irq_queues = irq_sets[0] + irq_sets[1] + 1;
 
-		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
-				nr_io_queues,
+		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
+				irq_queues,
 				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 
 		/*
@@ -2125,12 +2119,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		 * likely does not. Back down to ask for just one vector.
 		 */
 		if (result == -ENOSPC) {
-			nr_io_queues--;
-			if (!nr_io_queues)
+			irq_queues--;
+			if (!irq_queues)
 				return result;
 			continue;
 		} else if (result == -EINVAL) {
-			nr_io_queues = 1;
+			irq_queues = 1;
 			continue;
 		} else if (result <= 0)
 			return -EIO;

-- 
Jens Axboe
