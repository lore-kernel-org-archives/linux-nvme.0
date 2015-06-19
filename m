From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 19 Jun 2015 15:45:57 -0600
Subject: [PATCH] NVMe: Use CMB for the SQ if available
Message-ID: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>

Some controllers have a controller-side memory buffer available for use
for submissions, completions, lists, or data.

If a CMB is available, the entire CMB will be ioremapped and it will
attempt to map the SQs onto the CMB. The queues will be shrunk as needed.
The CMB will not be used if the queue depth is shrunk below some
threshold where it may have reduced performance over a larger queue
in system memory.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/block/nvme-core.c | 141 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/nvme.h      |  17 ++++++
 2 files changed, 148 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 12d5b7b..ebbba55 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -108,6 +108,8 @@ struct nvme_queue {
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
+	bool cmb_mapped;
+	struct nvme_command cmb_cmd ____cacheline_aligned;
 	u16 q_depth;
 	s16 cq_vector;
 	u16 sq_head;
@@ -337,6 +339,22 @@ static void async_completion(struct nvme_queue *nvmeq, void *ctx,
 	blk_mq_free_request(cmdinfo->req);
 }
 
+static inline void nvme_put_cmd(struct nvme_queue *nvmeq,
+				struct nvme_command *cmd)
+{
+	if (nvmeq->cmb_mapped)
+		memcpy_toio(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd,
+				sizeof(*cmd));
+}
+
+static inline struct nvme_command *nvme_get_cmd(struct nvme_queue *nvmeq)
+{
+	if (nvmeq->cmb_mapped)
+		return &nvmeq->cmb_cmd;
+
+	return &nvmeq->sq_cmds[nvmeq->sq_tail];
+}
+
 static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 				  unsigned int tag)
 {
@@ -376,7 +394,12 @@ static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 {
 	u16 tail = nvmeq->sq_tail;
 
-	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+	if (nvmeq->cmb_mapped)
+		memcpy_toio(&nvmeq->sq_cmds[tail], cmd,
+				sizeof(*cmd));
+	else
+		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
 	writel(tail, nvmeq->q_db);
@@ -720,15 +743,16 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
 		struct nvme_iod *iod)
 {
-	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	struct nvme_command *cmnd = nvme_get_cmd(nvmeq);
 
-	memcpy(cmnd, req->cmd, sizeof(struct nvme_command));
+	memcpy(cmnd, req->cmd, sizeof(*cmnd));
 	cmnd->rw.command_id = req->tag;
 	if (req->nr_phys_segments) {
 		cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 		cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
 	}
 
+	nvme_put_cmd(nvmeq, cmnd);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
@@ -744,7 +768,7 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 {
 	struct nvme_dsm_range *range =
 				(struct nvme_dsm_range *)iod_list(iod)[0];
-	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	struct nvme_command *cmnd = nvme_get_cmd(nvmeq);
 
 	range->cattr = cpu_to_le32(0);
 	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
@@ -758,6 +782,7 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->dsm.nr = 0;
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
+	nvme_put_cmd(nvmeq, cmnd);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
@@ -766,13 +791,14 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 								int cmdid)
 {
-	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	struct nvme_command *cmnd = nvme_get_cmd(nvmeq);
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->common.opcode = nvme_cmd_flush;
 	cmnd->common.command_id = cmdid;
 	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
 
+	nvme_put_cmd(nvmeq, cmnd);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
@@ -782,7 +808,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
 	struct request *req = iod_get_private(iod);
-	struct nvme_command *cmnd;
+	struct nvme_command *cmnd = nvme_get_cmd(nvmeq);
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -794,7 +820,6 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
-	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
 	memset(cmnd, 0, sizeof(*cmnd));
 
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
@@ -825,6 +850,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
+	nvme_put_cmd(nvmeq, cmnd);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
@@ -1361,7 +1387,8 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
-	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
+	if (!nvmeq->cmb_mapped)
+		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
 					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	kfree(nvmeq);
 }
@@ -1434,6 +1461,41 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
+static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
+				int entry_size)
+{
+	int q_depth = dev->q_depth;
+	unsigned q_size_aligned = roundup(q_depth * entry_size, dev->page_size);
+	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
+		q_depth = rounddown(dev->cmb_size / nr_io_queues,
+					dev->page_size) / entry_size;
+
+		/* Ensure the reduced q_depth is above some threshold where it
+		would be better to map queues in system memory with the
+		original depth */
+		if (q_depth < 64)
+			return -ENOMEM;
+	}
+
+	return q_depth;
+}
+
+static void *nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
+				int qid, int depth)
+{
+	if (qid && NVME_CMB_SQS(dev->cmbsz) && dev->cmb) {
+		unsigned offset = (qid - 1) *
+					roundup(SQ_SIZE(depth), dev->page_size);
+		nvmeq->cmb_mapped = true;
+		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
+		return (void *)((uintptr_t)dev->cmb + offset);
+	}
+
+	nvmeq->cmb_mapped = false;
+	return dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+					&nvmeq->sq_dma_addr, GFP_KERNEL);
+}
+
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth)
 {
@@ -1446,8 +1508,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
+	nvmeq->sq_cmds = nvme_alloc_sq_cmds(dev, nvmeq, qid, depth);
 	if (!nvmeq->sq_cmds)
 		goto free_cqdma;
 
@@ -2132,6 +2193,54 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
+static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
+{
+	u64 szu, size, offset;
+	u32 cmbloc, cmbsz;
+	resource_size_t bar_size;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	void __iomem *cmb;
+	dma_addr_t dma_addr;
+
+	cmbsz = readl(&dev->bar->cmbsz);
+	if (!(NVME_CMB_SZ(cmbsz)))
+		return NULL;
+
+	dev->cmbsz = cmbsz;
+	cmbloc = readl(&dev->bar->cmbloc);
+
+	szu = 1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
+	size = szu * NVME_CMB_SZ(dev->cmbsz);
+	offset = szu * NVME_CMB_OFST(cmbloc);
+	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
+
+	if (offset > bar_size)
+		return NULL;
+
+	/* Controllers may support a CMB size larger than their BAR,
+	for example, due to being behind a bridge. Reduce the CMB to
+	the reported size of the BAR */
+	if (size > bar_size - offset);
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
@@ -2150,6 +2259,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
+	if (NVME_CMB_SQS(dev->cmbsz) && dev->cmb) {
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
@@ -2410,6 +2528,8 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
+		dev->cmb = nvme_map_cmb(dev);
 
 	return 0;
 
@@ -3108,6 +3228,7 @@ static void nvme_remove(struct pci_dev *pdev)
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
