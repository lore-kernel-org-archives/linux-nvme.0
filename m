From: keith.busch@intel.com (Keith Busch)
Date: Thu,  3 Jan 2019 14:09:51 -0700
Subject: [PATCH 1/4] nvme-pci: Set tagset nr_maps just once
Message-ID: <20190103210954.11129-1-keith.busch@intel.com>

The driver overwrites the intermediate nr_map assignments to
HCTX_MAX_TYPES, so remove those unnecessary temporary settings.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a24d50..98332d0a80f0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2291,9 +2291,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = 2; /* default + read */
-		if (dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.nr_maps++;
 		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
-- 
2.14.4
