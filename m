From: hch@lst.de (Christoph Hellwig)
Date: Wed,  2 Mar 2016 18:07:10 +0100
Subject: [PATCH 1/5] nvme: also set BLK_MQ_F_SHOULD_MERGE for the admin queue
In-Reply-To: <1456938434-20387-1-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
Message-ID: <1456938434-20387-2-git-send-email-hch@lst.de>

There is no reason to treat the admin queue different in terms of
request merging.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
Tested-by: Jeff Lien <Jeff.Lien at hgst.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 680f578..19be56a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1289,6 +1289,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
-- 
2.1.4
