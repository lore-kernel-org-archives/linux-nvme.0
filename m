From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:55:46 +0100
Subject: [PATCH 02/11] nvme: fix admin queue depth
In-Reply-To: <1448996155-12072-1-git-send-email-hch@lst.de>
References: <1448996155-12072-1-git-send-email-hch@lst.de>
Message-ID: <1448996155-12072-3-git-send-email-hch@lst.de>

The number in tag_set->queue depth includes the reserved tags.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c83f0d8..686a4e2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1431,7 +1431,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 	if (!dev->ctrl.admin_q) {
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
 		dev->admin_tagset.nr_hw_queues = 1;
-		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
+		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH;
 		dev->admin_tagset.reserved_tags = 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
-- 
1.9.1
