From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu,  5 Jan 2017 15:18:51 -0700
Subject: [PATCH] NVME: Fix CMB types
Message-ID: <1483654731-12049-1-git-send-email-jonathan.derrick@intel.com>

ioremapping and the Create SQes command expect a phys_addr_t, so convert
current usages of dma_addr_t to this type. Also break out the current
reuse of sq_dma_addr into dma and physical addresses, depending on if
CMB is being used for SQes.

Reported by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
Hope this is a good stopgap until we get a more formalized CMB
management code. Also I don't know whose tree we are using now, so this
applies to axboe/master

 drivers/nvme/host/pci.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 19beeb7..41e36e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -96,7 +96,7 @@ struct nvme_dev {
 	struct mutex shutdown_lock;
 	bool subsystem;
 	void __iomem *cmb;
-	dma_addr_t cmb_dma_addr;
+	phys_addr_t cmb_phys_addr;
 	u64 cmb_size;
 	u32 cmbsz;
 	u32 cmbloc;
@@ -123,6 +123,7 @@ struct nvme_queue {
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
+	phys_addr_t sq_phys_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
 	u16 q_depth;
@@ -813,6 +814,13 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
 
+static u64 sq_addr(struct nvme_queue *nvmeq)
+{
+	if (nvmeq->sq_cmds)
+		return nvmeq->sq_dma_addr;
+	return nvmeq->sq_phys_addr;
+}
+
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
@@ -825,7 +833,7 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 	 */
 	memset(&c, 0, sizeof(c));
 	c.create_sq.opcode = nvme_admin_create_sq;
-	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
+	c.create_sq.prp1 = cpu_to_le64(sq_addr(nvmeq));
 	c.create_sq.sqid = cpu_to_le16(qid);
 	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(flags);
@@ -1031,7 +1039,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
 						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
+		nvmeq->sq_phys_addr = dev->cmb_phys_addr + offset;
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	} else {
 		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
@@ -1231,7 +1239,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa |= aqa << 16;
 
 	writel(aqa, dev->bar + NVME_REG_AQA);
-	lo_hi_writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
+	lo_hi_writeq(sq_addr(nvmeq), dev->bar + NVME_REG_ASQ);
 	lo_hi_writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
 
 	result = nvme_enable_ctrl(&dev->ctrl, cap);
@@ -1353,7 +1361,7 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	void __iomem *cmb;
-	dma_addr_t dma_addr;
+	phys_addr_t phys_addr;
 
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!(NVME_CMB_SZ(dev->cmbsz)))
@@ -1379,12 +1387,12 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 	if (size > bar_size - offset)
 		size = bar_size - offset;
 
-	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
-	cmb = ioremap_wc(dma_addr, size);
+	phys_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
+	cmb = ioremap_wc(phys_addr, size);
 	if (!cmb)
 		return NULL;
 
-	dev->cmb_dma_addr = dma_addr;
+	dev->cmb_phys_addr = phys_addr;
 	dev->cmb_size = size;
 	return cmb;
 }
-- 
1.8.3.1
