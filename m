From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:28:23 +0100
Subject: [PATCH 05/16] nvme: fix admin queue depth
In-Reply-To: <1448090914-13121-1-git-send-email-hch@lst.de>
References: <1448090914-13121-1-git-send-email-hch@lst.de>
Message-ID: <1448090914-13121-6-git-send-email-hch@lst.de>

The number in tag_set->queue depth includes the reserved tags.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c5187b5..cc91938 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1488,7 +1488,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
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
