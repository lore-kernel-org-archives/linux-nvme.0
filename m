From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Thu,  7 Jul 2016 09:45:08 -0300
Subject: [PATCH v2 2/3] nvme: implement DMA_ATTR_NO_WARN
In-Reply-To: <1467895509-12194-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467895509-12194-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1467895509-12194-3-git-send-email-mauricfo@linux.vnet.ibm.com>

Use the DMA_ATTR_NO_WARN attribute on dma_map_sg() calls of nvme driver.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
---
Changelog:
 v2:
  - address warnings from checkpatch.pl (line wrapping and typos)

 drivers/nvme/host/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d1a8259..a7ccad8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -18,6 +18,7 @@
 #include <linux/blk-mq.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dma-attrs.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
@@ -65,6 +66,8 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static struct workqueue_struct *nvme_workq;
 
+static DEFINE_DMA_ATTRS(nvme_dma_attrs);
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -498,7 +501,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
-	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
+	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
+				&nvme_dma_attrs))
 		goto out;
 
 	if (!nvme_setup_prps(dev, req, size))
@@ -516,7 +520,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		if (rq_data_dir(req))
 			nvme_dif_remap(req, nvme_dif_prep);
 
-		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
+		if (!dma_map_sg_attrs(dev->dev, &iod->meta_sg, 1, dma_dir,
+					&nvme_dma_attrs))
 			goto out_unmap;
 	}
 
@@ -2118,6 +2123,9 @@ static int __init nvme_init(void)
 	result = pci_register_driver(&nvme_driver);
 	if (result)
 		destroy_workqueue(nvme_workq);
+
+	dma_set_attr(DMA_ATTR_NO_WARN, &nvme_dma_attrs);
+
 	return result;
 }
 
-- 
1.8.3.1
