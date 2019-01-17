From: chenhc@lemote.com (Huacai Chen)
Date: Thu, 17 Jan 2019 11:10:10 +0800
Subject: [PATCH] nvme: fix out-of-bounds access during irq vectors allocation
Message-ID: <1547694610-31879-1-git-send-email-chenhc@lemote.com>

While reducing irq_queues in the do-while loop in nvme_setup_irqs(),
the reduction of irq_sets[] is behind irq_queues. Below is an example.

On a 8 cpu platform, with default setting, nvme_setup_irqs() begin with
irq_queues = 8 (but when allocating irq vectors it will become 9 due to
the admin queue), affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0]
= 8. If MSI-X resources are not enough, then the do-while loop will
reduce irq vectors:

The 1st time call pci_alloc_irq_vectors_affinity(),
irq_queues = 9, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 8
The 2nd time call pci_alloc_irq_vectors_affinity(),
irq_queues = 8, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 8
The 3rd time call pci_alloc_irq_vectors_affinity(),
irq_queues = 7, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 7

However, this will cause an out of bounds access in __pci_enable_msix()
--> ... --> irq_create_affinity_masks() --> irq_build_affinity_masks().

In the 2nd round of reduction, let's pay attention to the calling of
irq_build_affinity_masks(affd, curvec, this_vecs, curvec, node_to_cpumask, masks):

The number of elements in masks is 8 (depends on nvecs which is equal to
irq_queues), curvec is 1 (depends on affd.pre_vectors), then
irq_build_affinity_masks() will access 8 elements in masks (depends on
this_vecs which is equal to affd.sets[0]), and the last element is out
of bounds.

So the root cause is affd.sets[] + affd.pre_vectors should not be larger
than vectors to be allocated. In this patch we introduce alloc_queues to
indicate how many queues to allocate (not reuse irq_queues), and so we
can adjust affd.set[] correctly (depends on irq_queues) to avoid out of
bounds access.

After this patch:

The 1st time call pci_alloc_irq_vectors_affinity(),
irq_queues = 8, alloc_queues = 9, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 8
The 2nd time call pci_alloc_irq_vectors_affinity(),
irq_queues = 7, alloc_queues = 8, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 7
The 3rd time call pci_alloc_irq_vectors_affinity(),
irq_queues = 6, alloc_queues = 7, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 6

Fixes: 6451fe73fa0f542a49bf ("nvme: fix irq vs io_queue calculations")
Signed-off-by: Huacai Chen <chenhc at lemote.com>
---
 drivers/nvme/host/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index deb1a66..171fa7b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2084,7 +2084,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.sets = irq_sets,
 	};
 	int result = 0;
-	unsigned int irq_queues, this_p_queues;
+	unsigned int irq_queues, this_p_queues, alloc_queues;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one IO
@@ -2116,11 +2116,13 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		 * 1 + 1 queues, just ask for a single vector. We'll share
 		 * that between the single IO queue and the admin queue.
 		 */
-		if (result >= 0 && irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
+		if (irq_queues == 1)
+			alloc_queues = 1;
+		else
+			alloc_queues = irq_sets[0] + irq_sets[1] + 1;
 
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
+		result = pci_alloc_irq_vectors_affinity(pdev, alloc_queues,
+				alloc_queues,
 				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 
 		/*
-- 
2.7.0
