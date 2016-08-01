From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Mon,  1 Aug 2016 19:59:50 -0300
Subject: [PATCH 3/3] nvme: use the DMA_ATTR_NO_WARN attribute
In-Reply-To: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1470092390-25451-4-git-send-email-mauricfo@linux.vnet.ibm.com>

Use the DMA_ATTR_NO_WARN attribute for the dma_map_sg() call of the nvme
driver that returns BLK_MQ_RQ_QUEUE_BUSY (not for BLK_MQ_RQ_QUEUE_ERROR).

Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7c33f9..eeaeae0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -503,7 +503,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
-	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
+	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
+				DMA_ATTR_NO_WARN))
 		goto out;
 
 	if (!nvme_setup_prps(dev, req, size))
-- 
1.8.3.1
