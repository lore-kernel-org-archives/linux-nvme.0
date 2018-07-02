From: zhangweiping@didichuxing.com (Weiping Zhang)
Date: Tue, 3 Jul 2018 00:35:22 +0800
Subject: [PATCH v2 1/2] nvme-pci: release iomap and prp_pools in
 nvme_pci_free_ctrl
In-Reply-To: <cover.1530548893.git.zhangweiping@didichuxing.com>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
Message-ID: <c9dc94bd6b434273ed69c47b06b4f55fb495254c.1530548893.git.zhangweiping@didichuxing.com>

nvme_free_ctrl is the final release function all allocated resource
should be free safety in this function. Release iomap and prp_pools
in nvme_pci_free_ctrl, otherwise these two resource cann't be
released if init failed in nvme_reset_work.

Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..92a8b5b2b39e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2279,6 +2279,8 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
 	nvme_dbbuf_dma_free(dev);
+	nvme_release_prp_pools(dev);
+	nvme_dev_unmap(dev);
 	put_device(dev->dev);
 	if (dev->tagset.tags)
 		blk_mq_free_tag_set(&dev->tagset);
@@ -2642,8 +2644,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_uninit_ctrl(&dev->ctrl);
-	nvme_release_prp_pools(dev);
-	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-- 
2.14.1
