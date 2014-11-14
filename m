From: axboe@fb.com (Jens Axboe)
Date: Fri, 14 Nov 2014 09:49:26 -0700
Subject: [PATCH] NVMe: make setup work for devices that don't do INTx
Message-ID: <20141114164926.GC12860@kernel.dk>

The setup/probe part currently relies on INTx being there and
working, that's not always the case. For devices that don't
advertise INTx, enable a single MSIx vector early on and disable
it again before we ask for our full range of queue vecs.

Signed-off-by: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index fc2fc53992cb..ee533aabf479 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2009,6 +2009,13 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[0].vector, adminq);
 
+	/*
+	 * If we enable msix early due to not intx, disable it again before
+	 * setting up the full range we need.
+	 */
+	if (!pdev->irq)
+		pci_disable_msix(pdev);
+
 	for (i = 0; i < nr_io_queues; i++)
 		dev->entry[i].entry = i;
 	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
@@ -2161,10 +2168,22 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
 	if (!dev->bar)
 		goto disable;
+
 	if (readl(&dev->bar->csts) == -1) {
 		result = -ENODEV;
 		goto unmap;
 	}
+
+	/*
+	 * Some devices don't advertse INTx interrupts, pre-enable a single
+	 * MSIX vec for setup. We'll adjust this later.
+	 */
+	if (!pdev->irq) {
+		result = pci_enable_msix(pdev, dev->entry, 1);
+		if (result < 0)
+			goto unmap;
+	}
+
 	cap = readq(&dev->bar->cap);
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
-- 
1.9.1

-- 
Jens Axboe
