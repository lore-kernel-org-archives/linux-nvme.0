From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:58 +0100
Subject: [PATCH 12/14] NVMe: Factor out nvme_init_interrupts()
In-Reply-To: <cover.1390897693.git.agordeev@redhat.com>
References: <cover.1390897693.git.agordeev@redhat.com>
Message-ID: <c92fd4e4e9c7f4548c9fdcf4332ed9c2e2025b51.1390897693.git.agordeev@redhat.com>

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/nvme-core.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 1e30c42..39868be 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1909,13 +1909,10 @@ static int nvme_init_bar(struct nvme_dev *dev, int nr_io_queues)
 	return nr_io_queues;
 }
 
-static int nvme_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
+static int nvme_init_interrupts(struct nvme_dev *dev, int nr_io_queues)
 {
 	struct pci_dev *pdev = dev->pci_dev;
-	int result, cpu, i, vecs, q_depth;
-
-	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[dev->queues[0]->cq_vector].vector, dev->queues[0]);
+	int result, i, vecs;
 
 	vecs = nr_io_queues;
 	for (i = 0; i < vecs; i++)
@@ -1945,13 +1942,26 @@ static int nvme_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
 		}
 	}
 
+	return vecs;
+}
+
+static int nvme_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
+{
+	int result, cpu, i, q_depth;
+
+	/* Deregister the admin queue's interrupt */
+	free_irq(dev->entry[dev->queues[0]->cq_vector].vector, dev->queues[0]);
+
 	/*
 	 * Should investigate if there's a performance win from allocating
 	 * more queues than interrupt vectors; it might allow the submission
 	 * path to scale better, even if the receive path is limited by the
 	 * number of interrupts.
+	 *
+	 * The admin queue's interrupt number is changed in case of
+	 * successful MSI-X or MSI allocation.
 	 */
-	nr_io_queues = vecs;
+	nr_io_queues = nvme_init_interrupts(dev, nr_io_queues);
 
 	result = queue_request_irq(dev->queues[0], "nvme admin");
 	if (result) {
-- 
1.7.7.6
