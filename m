From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 14 Feb 2019 20:23:46 +0800
Subject: [PATCH V4 3/4] nvme-pci: Simplify interrupt allocation
In-Reply-To: <20190214122347.17372-1-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
Message-ID: <20190214122347.17372-4-ming.lei@redhat.com>

The NVME PCI driver contains a tedious mechanism for interrupt
allocation, which is necessary to adjust the number and size of interrupt
sets to the maximum available number of interrupts which depends on the
underlying PCI capabilities and the available CPU resources.

It works around the former short comings of the PCI and core interrupt
allocation mechanims in combination with interrupt sets.

The PCI interrupt allocation function allows to provide a maximum and a
minimum number of interrupts to be allocated and tries to allocate as
many as possible. This worked without driver interaction as long as there
was only a single set of interrupts to handle.

With the addition of support for multiple interrupt sets in the generic
affinity spreading logic, which is invoked from the PCI interrupt
allocation, the adaptive loop in the PCI interrupt allocation did not
work for multiple interrupt sets. The reason is that depending on the
total number of interrupts which the PCI allocation adaptive loop tries
to allocate in each step, the number and the size of the interrupt sets
need to be adapted as well. Due to the way the interrupt sets support was
implemented there was no way for the PCI interrupt allocation code or the
core affinity spreading mechanism to invoke a driver specific function
for adapting the interrupt sets configuration.

As a consequence the driver had to implement another adaptive loop around
the PCI interrupt allocation function and calling that with maximum and
minimum interrupts set to the same value. This ensured that the
allocation either succeeded or immediately failed without any attempt to
adjust the number of interrupts in the PCI code.

The core code now allows drivers to provide a callback to recalculate the
number and the size of interrupt sets during PCI interrupt allocation,
which in turn allows the PCI interrupt allocation function to be called
in the same way as with a single set of interrupts. The PCI code handles
the adaptive loop and the interrupt affinity spreading mechanism invokes
the driver callback to adapt the interrupt set configuration to the
current loop value. This replaces the adaptive loop in the driver
completely.

Implement the NVME specific callback which adjusts the interrupt sets
configuration and remove the adaptive allocation loop.

Reviewed-by: Jens Axboe <axboe at kernel.dk>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 62 +++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 193d94caf457..02ae653bf2c3 100644
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
+	affd->set_size[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
+	affd->set_size[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
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
-	int *irq_sets = affd.set_size;
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
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	return pci_register_driver(&nvme_driver);
 }
 
-- 
2.9.5
