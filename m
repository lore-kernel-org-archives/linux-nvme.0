From: lina.lulina@huawei.com (Lulina (A))
Date: Fri, 21 Dec 2018 01:07:25 +0000
Subject: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
Message-ID: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>

The case is that nvme device support NVME_CTRL_OACS_DBBUF_SUPP, and
return failed when the driver sent nvme_admin_dbbuf. The nvmeq->dbbuf_sq_db
point to freed memory, as nvme_dbbuf_set is called after nvme_dbbuf_init.

Signed-off-by: lulina <lina.lulina at huawei.com>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb20..a477905 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -251,16 +251,25 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int i;
 
 	if (dev->dbbuf_dbs) {
 		dma_free_coherent(dev->dev, mem_size,
 				  dev->dbbuf_dbs, dev->dbbuf_dbs_dma_addr);
 		dev->dbbuf_dbs = NULL;
+		for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+			dev->queues[i].dbbuf_sq_db = NULL;
+			dev->queues[i].dbbuf_cq_db = NULL;
+		}
 	}
 	if (dev->dbbuf_eis) {
 		dma_free_coherent(dev->dev, mem_size,
 				  dev->dbbuf_eis, dev->dbbuf_eis_dma_addr);
 		dev->dbbuf_eis = NULL;
+		for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+			dev->queues[i].dbbuf_sq_ei = NULL;
+			dev->queues[i].dbbuf_cq_ei = NULL;
+		}
 	}
 }
 
-- 
1.8.3.1
