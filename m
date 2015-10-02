From: hch@lst.de (Christoph Hellwig)
Date: Fri,  2 Oct 2015 19:58:17 +0200
Subject: [PATCH 5/7] nvme: remove duplicate call to nvme_set_irq_hints
In-Reply-To: <1443808699-4738-1-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
Message-ID: <1443808699-4738-6-git-send-email-hch@lst.de>

We just called the function a few lines earlier here.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 4660bfa..c35ead3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3005,7 +3005,6 @@ static void nvme_probe_work(struct work_struct *work)
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
-		nvme_set_irq_hints(dev);
 	}
 
 	return;
-- 
1.9.1
