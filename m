From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:39:43 +0200
Subject: [PATCH 4/8] nvme: delete dev from dev_list in nvme_reset
In-Reply-To: <1443879587-23553-1-git-send-email-hch@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
Message-ID: <1443879587-23553-5-git-send-email-hch@lst.de>

Device resets need to delete the device from the device list before
kicking of the reset an re-probe, otherwise we get the device added
to the list twice.  nvme_reset is the only side missing this deletion
at the moment, and this patch adds it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index bf35846..be35b1d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3089,6 +3089,7 @@ static int nvme_reset(struct nvme_dev *dev)
 
 	spin_lock(&dev_list_lock);
 	if (!work_pending(&dev->reset_work)) {
+		list_del_init(&dev->node);
 		queue_work(nvme_workq, &dev->reset_work);
 		ret = 0;
 	}
-- 
1.9.1
