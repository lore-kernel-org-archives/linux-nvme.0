From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Dec 2018 17:20:19 +0100
Subject: [PATCH] nvme-pci: only set nr_maps to 2 if poll queues are supported
Message-ID: <20181214162019.14847-1-hch@lst.de>

The block layer now enables polling support on a queue if nr_maps
includes the poll map, so we should only set that if we actually
support poll queues.

Fixes:  6544d229bf ("block: enable polling by default if a poll map is initalized")
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb9d8270f32c..8b62d0075e48 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2293,6 +2293,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
+		dev->tagset.nr_maps = 2; /* default + read */
+		if (dev->io_queues[HCTX_TYPE_POLL])
+			dev->tagset.nr_maps++;
 		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
-- 
2.19.2
