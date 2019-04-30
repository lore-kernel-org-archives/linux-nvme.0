From: klaus@birkelund.eu (Klaus Birkelund Jensen)
Date: Tue, 30 Apr 2019 18:53:29 +0200
Subject: [PATCH] nvme-pci: fix psdt field for single segment sgls
Message-ID: <20190430165329.6984-1-klaus@birkelund.eu>

The shortcut for single segment SGL requests did not set the PSDT field
to mark the request as using SGLs.

Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Klaus Birkelund Jensen <klaus.jensen at cnexlabs.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1eecde6b853..efc1da56521c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -830,6 +830,7 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
 
+	cmnd->flags = NVME_CMD_SGL_METABUF;
 	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
 	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
 	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
-- 
2.21.0
