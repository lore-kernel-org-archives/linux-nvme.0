From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 25 Feb 2016 19:36:38 -0700
Subject: [Patchv2 3/3] NVMe: Generate resource tree for CMB
In-Reply-To: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>
References: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1456454198-26683-4-git-send-email-jonathan.derrick@intel.com>

Maintains a resource tree for CMB resources. This new scheme uses
resource/region based allocation to manage CMB memory for in-driver
usage. For the NVMe PCIe driver, this information is exposed through
/proc/iomem.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h |  3 +-
 drivers/nvme/host/pci.c  | 76 +++++++++++++++++++++++++++++-------------------
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af58e3b..34f7b66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1083,7 +1083,7 @@ static ssize_t nvme_cmb_sq_offset_store(struct device *dev,
 	u64 sq_offset;
 
 	sscanf(buf, "%llu", &sq_offset);
-	if (sq_offset >= cmb->size)
+	if (sq_offset >= resource_size(cmb->res))
 		return -EINVAL;
 
 	cmb->sq_offset = sq_offset;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b5d0814..1c2a6a9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -118,9 +118,8 @@ struct nvme_ns {
 };
 
 struct nvme_cmb {
+	struct resource *res;
 	void __iomem *cmb;
-	dma_addr_t dma_addr;
-	u64 size;
 	u64 sq_offset;
 	u16 sq_depth;
 	unsigned long flags;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 97a46f4..a006fb2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -118,12 +118,13 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
+	char name[24];	/* nvme4294967295-65535\0 */
 	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
 	struct nvme_command __iomem *sq_cmds_io;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
+	struct resource *res;
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
@@ -1087,15 +1088,8 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 static int nvme_cmb_sq_depth(struct nvme_dev *dev, int nr_io_queues)
 {
 	struct nvme_cmb *cmb = dev->ctrl.cmb;
-	u32 sq_size;
-	u64 sqes_size;
-
-	if (!cmb->sq_depth)
-		return -EINVAL;
-
-	sq_size = cmb->sq_depth * sizeof(struct nvme_command);
-	sqes_size = sq_size * nr_io_queues;
-	if (cmb->sq_offset + sqes_size > cmb->size)
+	u64 sqes_size =	(u64) SQ_SIZE(cmb->sq_depth) * nr_io_queues;
+	if (cmb->sq_offset + sqes_size > resource_size(cmb->res))
 		return -ENOMEM;
 
 	return cmb->sq_depth;
@@ -1107,7 +1101,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	struct nvme_cmb *cmb = dev->ctrl.cmb;
 	if (qid && cmb->cmb && cmb->sq_depth) {
 		u32 offset = (qid - 1) * SQ_SIZE(depth);
-		nvmeq->sq_dma_addr = cmb->dma_addr + offset;
+		struct resource *res = __request_region(cmb->res,
+					cmb->res->start + offset,
+					SQ_SIZE(depth), nvmeq->name,
+					IORESOURCE_EXCLUSIVE);
+		if (!res)
+			return -ENOMEM;
+		nvmeq->res = res;
+
+		nvmeq->sq_dma_addr = res->start;
 		nvmeq->sq_cmds_io = cmb->cmb + offset;
 	} else {
 		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
@@ -1157,7 +1159,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
-	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
+	snprintf(nvmeq->name, sizeof(nvmeq->name), "nvme%dq%d",
 			dev->ctrl.instance, qid);
 	spin_lock_init(&nvmeq->q_lock);
 	nvmeq->cq_head = 0;
@@ -1221,7 +1223,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	result = queue_request_irq(dev, nvmeq, nvmeq->name);
 	if (result < 0)
 		goto release_sq;
 
@@ -1335,7 +1337,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		goto free_nvmeq;
 
 	nvmeq->cq_vector = 0;
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	result = queue_request_irq(dev, nvmeq, nvmeq->name);
 	if (result) {
 		nvmeq->cq_vector = -1;
 		goto free_nvmeq;
@@ -1456,25 +1458,26 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 
 static int nvme_pci_map_cmb(struct nvme_ctrl *ctrl)
 {
+	struct pci_dev *pdev = to_pci_dev(ctrl->dev);
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	struct nvme_cmb *cmb = ctrl->cmb;
+	struct resource *res, *parent;
 	u64 szu, size, offset;
 	u32 cmbsz, cmbloc;
 	resource_size_t bar_size;
-	struct nvme_cmb *cmb = ctrl->cmb;
-	struct pci_dev *pdev = to_pci_dev(ctrl->dev);
-	struct nvme_dev *dev = to_nvme_dev(ctrl);
-	dma_addr_t dma_addr;
-	void __iomem *cmb_ioaddr;
+	int bir;
 
 	cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!(NVME_CMB_SZ(cmbsz)))
 		return -EINVAL;
 
 	cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
+	bir = NVME_CMB_BIR(cmbloc);
 
 	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(cmbsz));
 	size = szu * NVME_CMB_SZ(cmbsz);
 	offset = szu * NVME_CMB_OFST(cmbloc);
-	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
+	bar_size = pci_resource_len(pdev, bir);
 
 	if (offset > bar_size) {
 		dev_warn(dev->dev, "CMB supported but offset does not fit "
@@ -1490,14 +1493,18 @@ static int nvme_pci_map_cmb(struct nvme_ctrl *ctrl)
 	if (size > bar_size - offset)
 		size = bar_size - offset;
 
-	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) + offset;
-	cmb_ioaddr = ioremap_wc(dma_addr, size);
-	if (!cmb_ioaddr)
+	parent = pdev->resource[bir].child;
+	res = __request_region(parent, parent->start + offset, size, "cmb", 0);
+	if (!res)
 		return -ENOMEM;
 
-	cmb->cmb = cmb_ioaddr;
-	cmb->dma_addr = dma_addr;
-	cmb->size = size;
+	cmb->cmb = ioremap_wc(res->start, size);
+	if (!cmb->cmb) {
+		__release_region(parent, res->start, resource_size(res));
+		return -ENOMEM;
+	}
+
+	cmb->res = res;
 	cmb->flags |= NVME_CMB_SQS(cmbsz) ? NVME_CMB_SQ_SUPPORTED : 0;
 	cmb->flags |= NVME_CMB_CQS(cmbsz) ? NVME_CMB_CQ_SUPPORTED : 0;
 	cmb->flags |= NVME_CMB_WDS(cmbsz) ? NVME_CMB_WD_SUPPORTED : 0;
@@ -1510,9 +1517,15 @@ static void nvme_pci_unmap_cmb(struct nvme_ctrl *ctrl)
 {
 	struct nvme_cmb *cmb = ctrl->cmb;
 	if (cmb->cmb) {
+		struct resource *res;
+		for (res = cmb->res->child; res; res = res->sibling) {
+			__release_region(res->parent, res->start,
+						resource_size(res));
+		}
+		__release_region(cmb->res->parent, cmb->res->start,
+					resource_size(cmb->res));
 		iounmap(cmb->cmb);
 		cmb->cmb = NULL;
-		cmb->dma_addr = 0;
 	}
 }
 
@@ -1545,12 +1558,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		result = 0;
 	}
 
-	if (cmb->flags & NVME_CMB_SQ_SUPPORTED) {
+	if (cmb->flags & NVME_CMB_SQ_SUPPORTED && cmb->sq_depth) {
 		result = nvme_cmb_sq_depth(dev, nr_io_queues);
 		if (result > 0)
 			dev->q_depth = result;
-		else
+		else {
+			dev_warn(dev->dev, "Could not allocate %d-deep queues "
+					"in CMB\n", cmb->sq_depth);
 			cmb->sq_depth = 0;
+		}
 	}
 
 	size = db_bar_size(dev, nr_io_queues);
@@ -1600,7 +1616,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	nr_io_queues = vecs;
 	dev->max_qid = nr_io_queues;
 
-	result = queue_request_irq(dev, adminq, adminq->irqname);
+	result = queue_request_irq(dev, adminq, adminq->name);
 	if (result) {
 		adminq->cq_vector = -1;
 		goto free_queues;
-- 
2.1.4
