From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 16 Jul 2015 16:51:28 -0600
Subject: [PATCHv4 2/2] NVMe: Use CMB for the IO SQes if available
In-Reply-To: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>
References: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1437087088-1628-3-git-send-email-jonathan.derrick@intel.com>

Some controllers have a controller-side memory buffer available for use
for submissions, completions, lists, or data.

If a CMB is available, the entire CMB will be ioremapped and it will
attempt to map the IO SQes onto the CMB. The queues will be shrunk as
needed. The CMB will not be used if the queue depth is shrunk below some
threshold where it may have reduced performance over a larger queue
in system memory.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/block/nvme-core.c | 119 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h      |  17 +++++++
 2 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ef5ef76..f2a7eff 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -72,6 +72,10 @@ module_param(nvme_char_major, int, 0);
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
+static int use_cmb_sqes = 1;
+module_param(use_cmb_sqes, int, 0644);
+MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
+
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
@@ -103,6 +107,7 @@ struct nvme_queue {
 	char irqname[24];	/* nvme4294967295-65535\0 */
 	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
+	struct nvme_command __iomem *sq_cmds_io;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
@@ -376,7 +381,11 @@ static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 {
 	u16 tail = nvmeq->sq_tail;
 
-	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+	if (nvmeq->sq_cmds_io)
+		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
+	else
+		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
 	writel(tail, nvmeq->q_db);
@@ -1352,7 +1361,8 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
-	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
+	if (nvmeq->sq_cmds)
+		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
 					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	kfree(nvmeq);
 }
@@ -1425,6 +1435,42 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
+static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
+				int entry_size)
+{
+	int q_depth = dev->q_depth;
+	unsigned q_size_aligned = roundup(q_depth * entry_size, dev->page_size);
+
+	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
+		q_depth = rounddown(dev->cmb_size / nr_io_queues,
+					dev->page_size) / entry_size;
+
+		/*
+		 * Ensure the reduced q_depth is above some threshold where it
+		 * would be better to map queues in system memory with the
+		 * original depth
+		 */
+		if (q_depth < 64)
+			return -ENOMEM;
+	}
+
+	return q_depth;
+}
+
+static void nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
+				int qid, int depth)
+{
+	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
+		unsigned offset = (qid - 1) *
+					roundup(SQ_SIZE(depth), dev->page_size);
+		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
+		nvmeq->sq_cmds_io = dev->cmb + offset;
+	} else {
+		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+					&nvmeq->sq_dma_addr, GFP_KERNEL);
+	}
+}
+
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth)
 {
@@ -1437,9 +1483,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
-	if (!nvmeq->sq_cmds)
+	nvme_alloc_sq_cmds(dev, nvmeq, qid, depth);
+	if (!nvmeq->sq_cmds && !nvmeq->sq_cmds_io)
 		goto free_cqdma;
 
 	nvmeq->q_dmadev = dev->dev;
@@ -2123,6 +2168,58 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
+static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
+{
+	u64 szu, size, offset;
+	u32 cmbloc;
+	resource_size_t bar_size;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	void __iomem *cmb;
+	dma_addr_t dma_addr;
+
+	if (!use_cmb_sqes)
+		return NULL;
+
+	dev->cmbsz = readl(&dev->bar->cmbsz);
+	if (!(NVME_CMB_SZ(dev->cmbsz)))
+		return NULL;
+
+	cmbloc = readl(&dev->bar->cmbloc);
+
+	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
+	size = szu * NVME_CMB_SZ(dev->cmbsz);
+	offset = szu * NVME_CMB_OFST(cmbloc);
+	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
+
+	if (offset > bar_size)
+		return NULL;
+
+	/*
+	 * Controllers may support a CMB size larger than their BAR,
+	 * for example, due to being behind a bridge. Reduce the CMB to
+	 * the reported size of the BAR
+	 */
+	if (size > bar_size - offset)
+		size = bar_size - offset;
+
+	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) + offset;
+	cmb = ioremap_wc(dma_addr, size);
+	if (!cmb)
+		return NULL;
+
+	dev->cmb_dma_addr = dma_addr;
+	dev->cmb_size = size;
+	return cmb;
+}
+
+static inline void nvme_release_cmb(struct nvme_dev *dev)
+{
+	if (dev->cmb) {
+		iounmap(dev->cmb);
+		dev->cmb = NULL;
+	}
+}
+
 static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 {
 	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
@@ -2141,6 +2238,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
+	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
+		result = nvme_cmb_qdepth(dev, nr_io_queues,
+				sizeof(struct nvme_command));
+		if (result > 0)
+			dev->q_depth = result;
+		else
+			nvme_release_cmb(dev);
+	}
+
 	size = db_bar_size(dev, nr_io_queues);
 	if (size > 8192) {
 		iounmap(dev->bar);
@@ -2401,6 +2507,8 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
+		dev->cmb = nvme_map_cmb(dev);
 
 	return 0;
 
@@ -3099,6 +3207,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
 	nvme_free_queues(dev, 0);
+	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c0d94ed..fa3fe16 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -32,6 +32,8 @@ struct nvme_bar {
 	__u32			aqa;	/* Admin Queue Attributes */
 	__u64			asq;	/* Admin SQ Base Address */
 	__u64			acq;	/* Admin CQ Base Address */
+	__u32			cmbloc; /* Controller Memory Buffer Location */
+	__u32			cmbsz;  /* Controller Memory Buffer Size */
 };
 
 #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
@@ -40,6 +42,17 @@ struct nvme_bar {
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
 
+#define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
+#define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
+#define NVME_CMB_SZ(cmbsz)	(((cmbsz) >> 12) & 0xfffff)
+#define NVME_CMB_SZU(cmbsz)	(((cmbsz) >> 8) & 0xf)
+
+#define NVME_CMB_WDS(cmbsz)	((cmbsz) & 0x10)
+#define NVME_CMB_RDS(cmbsz)	((cmbsz) & 0x8)
+#define NVME_CMB_LISTS(cmbsz)	((cmbsz) & 0x4)
+#define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
+#define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
+
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_CSS_NVM		= 0 << 4,
@@ -100,6 +113,10 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u32 page_size;
+	void __iomem *cmb;
+	dma_addr_t cmb_dma_addr;
+	u64 cmb_size;
+	u32 cmbsz;
 	u16 oncs;
 	u16 abort_limit;
 	u8 event_limit;
-- 
2.1.4
