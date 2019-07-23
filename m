From: yangerkun@huawei.com (yangerkun)
Date: Tue, 23 Jul 2019 11:23:13 +0800
Subject: [PATCH] Revert "nvme-pci: don't create a read hctx mapping without
 read queues"
Message-ID: <1563852193-6895-1-git-send-email-yangerkun@huawei.com>

This reverts commit 0298d5435276e7795b0b939d74827f6e775e7009.

With this patch, set 'poll_queues > hard queues' will lead to 'nr_read_queues = 0'
in nvme_calc_irq_sets. Then poll_queues setting can fail since dev->tagset.nr_maps
equals to 2 and nvme_pci_map_queues will not do map for poll queues.

Signed-off-by: yangerkun <yangerkun at huawei.com>
---
 drivers/nvme/host/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb970ca..77555ad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2254,9 +2254,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = 1; /* default */
-		if (dev->io_queues[HCTX_TYPE_READ])
-			dev->tagset.nr_maps++;
+		dev->tagset.nr_maps = 2; /* default + read */
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-- 
2.7.4
