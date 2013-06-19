From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 19 Jun 2013 13:37:59 -0400
Subject: [PATCH] Clean up nvme_setup_io_queues a little
Message-ID: <20130619173759.GU8211@linux.intel.com>


I didn't like the outcome of adding the MSI support to
nvme_setup_io_queues; I found q_count and nr_io_queues confusing, and
that was reinforced when I saw how we used q_count in set_queue_count(),
right above nvme_setup_io_queues.

This patch handles the need to copy the value by using a variable
called 'vecs' which we initialise (potentially twice) to nr_io_queues,
and then copy back into nr_io_queues at the end.  It also opens up the
intriguing possibility that maybe if we have a device that supports,
say, 32 IO queues, but we can only allocate 8 MSI vectors, then we can
still use those extra queues, but service them from the reduced set
of interrupts.  Maybe.  In the future.  After sufficient benchmarking :-)

The code looks a lot simpler as a result, at least to me.  But I'm biased,
so I crave feedback on whether this is an improvement.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ce79a59..de3a759 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1638,7 +1638,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = dev->pci_dev;
-	int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_count;
+	int result, cpu, i, vecs, nr_io_queues, db_bar_size, q_depth;
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1647,7 +1647,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
-	q_count = nr_io_queues;
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[0].vector, dev->queues[0]);
 
@@ -1659,39 +1658,42 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		dev->queues[0]->q_db = dev->dbs;
 	}
 
-	for (i = 0; i < nr_io_queues; i++)
+	vecs = nr_io_queues;
+	for (i = 0; i < vecs; i++)
 		dev->entry[i].entry = i;
 	for (;;) {
-		result = pci_enable_msix(pdev, dev->entry, nr_io_queues);
-		if (result == 0) {
+		result = pci_enable_msix(pdev, dev->entry, vecs);
+		if (result <= 0)
 			break;
-		} else if (result > 0) {
-			nr_io_queues = result;
-			continue;
-		} else {
-			nr_io_queues = 0;
-			break;
-		}
+		vecs = result;
 	}
 
-	if (nr_io_queues == 0) {
-		nr_io_queues = q_count;
+	if (result < 0) {
+		vecs = nr_io_queues;
+		if (vecs > 32)
+			vecs = 32;
 		for (;;) {
-			result = pci_enable_msi_block(pdev, nr_io_queues);
+			result = pci_enable_msi_block(pdev, vecs);
 			if (result == 0) {
-				for (i = 0; i < nr_io_queues; i++)
+				for (i = 0; i < vecs; i++)
 					dev->entry[i].vector = i + pdev->irq;
 				break;
-			} else if (result > 0) {
-				nr_io_queues = result;
-				continue;
-			} else {
-				nr_io_queues = 1;
+			} else if (result < 0) {
+				vecs = 1;
 				break;
 			}
+			vecs = result;
 		}
 	}
 
+	/*
+	 * Should investigate if there's a performance win from allocating
+	 * more queues than interrupt vectors; it might allow the submission
+	 * path to scale better, even if the receive path is limited by the
+	 * number of interrupts.
+	 */
+	nr_io_queues = vecs;
+
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	/* XXX: handle failure here */
 
