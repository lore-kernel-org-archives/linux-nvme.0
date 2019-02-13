From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 13 Feb 2019 18:50:40 +0800
Subject: [PATCH V3 4/5] nvme-pci: avoid irq allocation retrying via .calc_sets
In-Reply-To: <20190213105041.13537-1-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
Message-ID: <20190213105041.13537-5-ming.lei@redhat.com>

Currently pre-caculate each set vectors, and this way requires same
'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
then nvme_setup_irqs() has to retry in case of allocation failure.

This usage & interface is a bit awkward because the retry should have
been avoided by providing one reasonable 'min_vecs'.

Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
can calculate each set's vector after IRQ vectors is allocated and
before spread IRQ, then NVMe's retry in case of irq allocation failure
can be removed.

Reviewed-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 62 +++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0086bdf80ea1..8c51252a897e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2078,14 +2078,25 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 	}
 }
 
+static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
+{
+	struct nvme_dev *dev = affd->priv;
+
+	nvme_calc_io_queues(dev, nvecs);
+
+	affd->set_vectors[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
+	affd->set_vectors[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
+	affd->nr_sets = 2;
+}
+
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct irq_affinity affd = {
 		.pre_vectors = 1,
-		.nr_sets = 2,
+		.calc_sets = nvme_calc_irq_sets,
+		.priv = dev,
 	};
-	int *irq_sets = affd.set_vectors;
 	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
@@ -2102,50 +2113,8 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
-	/*
-	 * For irq sets, we have to ask for minvec == maxvec. This passes
-	 * any reduction back to us, so we can adjust our queue counts and
-	 * IRQ vector needs.
-	 */
-	do {
-		nvme_calc_io_queues(dev, irq_queues);
-		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
-		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
-		if (!irq_sets[1])
-			affd.nr_sets = 1;
-
-		/*
-		 * If we got a failure and we're down to asking for just
-		 * 1 + 1 queues, just ask for a single vector. We'll share
-		 * that between the single IO queue and the admin queue.
-		 * Otherwise, we assign one independent vector to admin queue.
-		 */
-		if (irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
-
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
-				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
-
-		/*
-		 * Need to reduce our vec counts. If we get ENOSPC, the
-		 * platform should support mulitple vecs, we just need
-		 * to decrease our ask. If we get EINVAL, the platform
-		 * likely does not. Back down to ask for just one vector.
-		 */
-		if (result == -ENOSPC) {
-			irq_queues--;
-			if (!irq_queues)
-				return result;
-			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
-		} else if (result <= 0)
-			return -EIO;
-		break;
-	} while (1);
-
+	result = pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 	return result;
 }
 
@@ -3021,6 +2990,7 @@ static struct pci_driver nvme_driver = {
 
 static int __init nvme_init(void)
 {
+	BUILD_BUG_ON(2 > IRQ_MAX_SETS);
 	return pci_register_driver(&nvme_driver);
 }
 
-- 
2.9.5
