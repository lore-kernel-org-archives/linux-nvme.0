From: keith.busch@intel.com (Keith Busch)
Date: Mon,  1 Jul 2013 10:23:40 -0600
Subject: [PATCH] NVMe: handle ioremap failure
Message-ID: <1372695820-30841-1-git-send-email-keith.busch@intel.com>

Decrement the number of queues required for doorbell remapping until
the memory is successfully mapped for that size.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 711b51c..aaada3d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1686,7 +1686,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
 	if (db_bar_size > 8192) {
 		iounmap(dev->bar);
-		dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
+		while (nr_io_queues > 0) {
+			dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
+			if (!dev->bar)
+				nr_io_queues--;
+			else
+				break;
+			db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
+		}
+		if (!dev->bar)
+			return -ENOMEM;
+
 		dev->dbs = ((void __iomem *)dev->bar) + 4096;
 		dev->queues[0]->q_db = dev->dbs;
 	}
-- 
1.7.0.4
