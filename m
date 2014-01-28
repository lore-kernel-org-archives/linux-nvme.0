From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:57 +0100
Subject: [PATCH 11/14] NVMe: Factor out nvme_init_bar()
In-Reply-To: <cover.1390897693.git.agordeev@redhat.com>
References: <cover.1390897693.git.agordeev@redhat.com>
Message-ID: <751c697697ca9b38b9f775d0908bb0cc741fe68c.1390897693.git.agordeev@redhat.com>

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/nvme-core.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d81b4c4..1e30c42 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1886,10 +1886,10 @@ static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
 }
 
-static int nvme_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
+static int nvme_init_bar(struct nvme_dev *dev, int nr_io_queues)
 {
 	struct pci_dev *pdev = dev->pci_dev;
-	int result, cpu, i, vecs, size, q_depth;
+	int size;
 
 	size = db_bar_size(dev, nr_io_queues);
 	if (size > 8192) {
@@ -1906,6 +1906,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
 		dev->queues[0]->q_db = dev->dbs;
 	}
 
+	return nr_io_queues;
+}
+
+static int nvme_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
+{
+	struct pci_dev *pdev = dev->pci_dev;
+	int result, cpu, i, vecs, q_depth;
+
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[dev->queues[0]->cq_vector].vector, dev->queues[0]);
 
@@ -2420,6 +2428,10 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	if (result < 0)
 		goto disable;
 
+	result = nvme_init_bar(dev, result);
+	if (result < 0)
+		goto disable;
+
 	result = nvme_setup_io_queues(dev, result);
 	if (result)
 		goto disable;
-- 
1.7.7.6
