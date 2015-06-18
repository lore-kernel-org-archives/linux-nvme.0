From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 18 Jun 2015 19:22:51 +0800
Subject: [PATCH] NVMe: Remove the redundant sg_mar_end()
Message-ID: <1434626571-1652-1-git-send-email-wangyijing@huawei.com>

sg_init_table() already called sg_mark_end(),
remove the redundant one.

Signed-off-by: Yijing Wang <wangyijing at huawei.com>
---
 drivers/block/nvme-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 683dff2..f099275 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1708,7 +1708,6 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 		length -= (PAGE_SIZE - offset);
 		offset = 0;
 	}
-	sg_mark_end(&sg[i - 1]);
 	iod->nents = count;
 
 	nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
-- 
1.7.1
