From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 24 Dec 2018 11:15:53 +0800
Subject: [PATCH] nvme-pci: fix the wrong setting of nr_maps
Message-ID: <1545621353-1443-1-git-send-email-jianchao.w.wang@oracle.com>

We only set the nr_maps to 3 if poll queues are supported.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a..cc65fa8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2294,7 +2294,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.nr_maps = 2; /* default + read */
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
-		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
-- 
2.7.4
