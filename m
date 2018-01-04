From: joshi.k@samsung.com (Kanchan Joshi)
Date: Thu, 04 Jan 2018 20:32:09 +0530
Subject: [PATCH] nvme: Add weighted-round-robin arbitration support
References: <CGME20180104150334epcas1p14579a6ab7bcf1b6ce326d0bce89c91e1@epcas1p1.samsung.com>
Message-ID: <1515078129-4041-1-git-send-email-joshi.k@samsung.com>

This patch enables support for Weighted-Round-Robin (WRR) arbitration, so
that applications can make use of the prioritization capabilities natively
present in NVMe controller.

- It links existing io-nice classes (real-time, best-effort, none, low)
to NVMe priorities (urgent, high, medium, low).  This is done through
'request->ioprio' field inside 'queue_rq' function.

- Current driver has 1:1 mapping (1 SQ, 1 CQ) per cpu, encapsulated in
'nvmeq' structure.  This patch refactors the code so that N:1 mapping per
cpu can be created; 'nvmeq' has been changed to contain variable number of SQ
related fields.  For WRR, 4 submission-queues (corresponding to each queue
priorites) need to be created on each cpu.

- When 'enable_wrr' module param is passed, it creates 4:1 mapping and enables
controller in WRR mode.  Otherwise, it cotinues to retain 1:1 mapping and
controller remains in RR mode.

- NVMe device may have less number of queues than required for 4:1 mapping
per cpu.  For example, when num_possible_cpus is 64, 256 submission-queues are
required for 4:1 mapping while device may support, say, 128.  
This case is handled by creating 32 queue-pairs which are shared among 64 cpus.
Another way to handle this could have been reducing to 3:1 or 2:1 mapping
(and remapping 4 ionice classes as well).

-Admin queue, contains 1:1 mapping irrespective of the mode (RR or WRR) used.

Earlier I had collected results on 4.10
kernel, which indicate distribution happening as per
weights applied.  Please refer to (section 5) in this paper -
http://www.usenix.org/system/files/conference/hotstorage17/hotstorage17-paper-joshi.pdf
I see similar results in current kernel as well.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 drivers/nvme/host/core.c |   4 +-
 drivers/nvme/host/pci.c  | 310 +++++++++++++++++++++++++++++++----------------
 include/linux/nvme.h     |   1 +
 3 files changed, 210 insertions(+), 105 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e46e60..6920bdf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1649,9 +1649,9 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 
 	ctrl->page_size = 1 << page_shift;
 
-	ctrl->ctrl_config = NVME_CC_CSS_NVM;
+	ctrl->ctrl_config |= NVME_CC_CSS_NVM;
 	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
+	ctrl->ctrl_config |= NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3..5f99ee5e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -37,6 +37,13 @@
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
+#define SQ_PER_CORE_RR		1
+#define SQ_PER_CORE_WRR		4
+
+static bool enable_wrr = false;
+module_param(enable_wrr, bool, 0644);
+MODULE_PARM_DESC(enable_wrr, "enable wrr arbitration among I/O SQes");
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -111,6 +118,9 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+
+	/* 1 for RR, 4 for WRR */
+	u8 sq_per_core;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -147,24 +157,31 @@ struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
 	spinlock_t q_lock;
-	struct nvme_command *sq_cmds;
-	struct nvme_command __iomem *sq_cmds_io;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
-	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
-	u32 __iomem *q_db;
+	u32 __iomem *cq_db;
 	u16 q_depth;
 	s16 cq_vector;
-	u16 sq_tail;
 	u16 cq_head;
-	u16 qid;
+	u16 cq_id;
 	u8 cq_phase;
 	u8 cqe_seen;
-	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
-	u32 *dbbuf_sq_ei;
 	u32 *dbbuf_cq_ei;
+	/* sq related fields start here */
+	u8 nr_sq;
+	struct sq_data {
+		struct nvme_command *sq_cmds;
+		struct nvme_command __iomem *sq_cmds_io;
+		dma_addr_t sq_dma_addr;
+		u32 __iomem *sq_db;
+		u16 id;
+		u16 sq_tail;
+		u32 *dbbuf_sq_db;
+		u32 *dbbuf_sq_ei;
+	} sq[];
+
 };
 
 /*
@@ -181,6 +198,7 @@ struct nvme_iod {
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
+	int sq_indx;
 	dma_addr_t first_dma;
 	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
 	struct scatterlist *sg;
@@ -207,14 +225,14 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 }
 
-static inline unsigned int nvme_dbbuf_size(u32 stride)
+static inline unsigned int nvme_dbbuf_size(u32 stride, u8 sq_per_core)
 {
-	return ((num_possible_cpus() + 1) * 8 * stride);
+	return ((sq_per_core * num_possible_cpus() + 1) * 8 * stride);
 }
 
 static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
-	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride, dev->sq_per_core);
 
 	if (dev->dbbuf_dbs)
 		return 0;
@@ -239,7 +257,7 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 {
-	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride, dev->sq_per_core);
 
 	if (dev->dbbuf_dbs) {
 		dma_free_coherent(dev->dev, mem_size,
@@ -256,13 +274,17 @@ static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 static void nvme_dbbuf_init(struct nvme_dev *dev,
 			    struct nvme_queue *nvmeq, int qid)
 {
+	int i;
 	if (!dev->dbbuf_dbs || !qid)
 		return;
-
-	nvmeq->dbbuf_sq_db = &dev->dbbuf_dbs[sq_idx(qid, dev->db_stride)];
-	nvmeq->dbbuf_cq_db = &dev->dbbuf_dbs[cq_idx(qid, dev->db_stride)];
-	nvmeq->dbbuf_sq_ei = &dev->dbbuf_eis[sq_idx(qid, dev->db_stride)];
-	nvmeq->dbbuf_cq_ei = &dev->dbbuf_eis[cq_idx(qid, dev->db_stride)];
+	for (i = 0; i < nvmeq->nr_sq; i++) {
+		nvmeq->sq[i].dbbuf_sq_db =
+			&dev->dbbuf_dbs[sq_idx(nvmeq->sq[i].id, dev->db_stride)];
+		nvmeq->sq[i].dbbuf_sq_ei =
+			&dev->dbbuf_eis[sq_idx(nvmeq->sq[i].id, dev->db_stride)];
+	}
+	nvmeq->dbbuf_cq_db = &dev->dbbuf_dbs[cq_idx(nvmeq->cq_id, dev->db_stride)];
+	nvmeq->dbbuf_cq_ei = &dev->dbbuf_eis[cq_idx(nvmeq->cq_id, dev->db_stride)];
 }
 
 static void nvme_dbbuf_set(struct nvme_dev *dev)
@@ -425,21 +447,22 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
  * Safe to use from interrupt context
  */
 static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
-						struct nvme_command *cmd)
+						struct nvme_command *cmd,
+						int idx)
 {
-	u16 tail = nvmeq->sq_tail;
+	u16 tail = nvmeq->sq[idx].sq_tail;
 
-	if (nvmeq->sq_cmds_io)
-		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
+	if (nvmeq->sq[idx].sq_cmds_io)
+		memcpy_toio(&nvmeq->sq[idx].sq_cmds_io[tail], cmd, sizeof(*cmd));
 	else
-		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+		memcpy(&nvmeq->sq[idx].sq_cmds[tail], cmd, sizeof(*cmd));
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
-					      nvmeq->dbbuf_sq_ei))
-		writel(tail, nvmeq->q_db);
-	nvmeq->sq_tail = tail;
+	if (nvme_dbbuf_update_and_check_event(tail, nvmeq->sq[idx].dbbuf_sq_db,
+					      nvmeq->sq[idx].dbbuf_sq_ei))
+		writel(tail, nvmeq->sq[idx].sq_db);
+	nvmeq->sq[idx].sq_tail = tail;
 }
 
 static void **nvme_pci_iod_list(struct request *req)
@@ -448,7 +471,8 @@ static void **nvme_pci_iod_list(struct request *req)
 	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
 }
 
-static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
+static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev,
+					int sq_indx)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(rq);
 	int nseg = blk_rq_nr_phys_segments(rq);
@@ -469,6 +493,7 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	iod->npages = -1;
 	iod->nents = 0;
 	iod->length = size;
+	iod->sq_indx = sq_indx;
 
 	return BLK_STS_OK;
 }
@@ -780,7 +805,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 
 	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
 		return false;
-	if (!iod->nvmeq->qid)
+	if (!iod->nvmeq->cq_id)
 		return false;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return false;
@@ -859,6 +884,12 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	nvme_free_iod(dev, req);
 }
 
+static inline int ioprio_to_sqindx(struct nvme_queue *nvmeq, struct request *req)
+{
+	int ioprio_class;
+	ioprio_class = req->ioprio >> IOPRIO_CLASS_SHIFT;
+	return (ioprio_class % nvmeq->nr_sq);
+}
 /*
  * NOTE: ns is NULL when called on the admin queue.
  */
@@ -871,12 +902,18 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct nvme_command cmnd;
 	blk_status_t ret;
+	int sq_indx = 0;
+	/*
+	 * no need to check iopriority for admin queue, and when in RR mode
+	 */
+	if (nvmeq->nr_sq > SQ_PER_CORE_RR)
+		sq_indx = ioprio_to_sqindx(nvmeq, req);
 
 	ret = nvme_setup_cmd(ns, req, &cmnd);
 	if (ret)
 		return ret;
 
-	ret = nvme_init_iod(req, dev);
+	ret = nvme_init_iod(req, dev, sq_indx);
 	if (ret)
 		goto out_free_cmd;
 
@@ -894,7 +931,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		spin_unlock_irq(&nvmeq->q_lock);
 		goto out_cleanup_iod;
 	}
-	__nvme_submit_cmd(nvmeq, &cmnd);
+	__nvme_submit_cmd(nvmeq, &cmnd, sq_indx);
 	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
@@ -927,7 +964,7 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 	if (likely(nvmeq->cq_vector >= 0)) {
 		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
 						      nvmeq->dbbuf_cq_ei))
-			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+			writel(head, nvmeq->cq_db);
 	}
 }
 
@@ -935,7 +972,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		struct nvme_completion *cqe)
 {
 	struct request *req;
-
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
@@ -949,7 +985,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvmeq->qid == 0 &&
+	if (unlikely(nvmeq->cq_id == 0 &&
 			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
@@ -1054,7 +1090,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	__nvme_submit_cmd(nvmeq, &c);
+	__nvme_submit_cmd(nvmeq, &c, 0);
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
@@ -1086,28 +1122,36 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
 	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
-
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
 
-static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
+static int adapter_alloc_sq(struct nvme_dev *dev, int sq_indx,
 						struct nvme_queue *nvmeq)
 {
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
+	if (enable_wrr) {
+		/*
+		 * Note: io-prio class to nvme priority mapping
+		 * none -> medium, realtime -> urgent, best-effort -> high,
+		 * idle->low
+		 */
+		int prio[] = {NVME_SQ_PRIO_MEDIUM, NVME_SQ_PRIO_URGENT,
+			NVME_SQ_PRIO_HIGH, NVME_SQ_PRIO_LOW};
+		flags |= prio[sq_indx];
+	}
 	/*
 	 * Note: we (ab)use the fact that the prp fields survive if no data
 	 * is attached to the request.
 	 */
 	memset(&c, 0, sizeof(c));
 	c.create_sq.opcode = nvme_admin_create_sq;
-	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
-	c.create_sq.sqid = cpu_to_le16(qid);
+	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq[sq_indx].sq_dma_addr);
+	c.create_sq.sqid = cpu_to_le16(nvmeq->sq[sq_indx].id);
 	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(flags);
-	c.create_sq.cqid = cpu_to_le16(qid);
-
+	c.create_sq.cqid = cpu_to_le16(nvmeq->cq_id);
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
 
@@ -1202,7 +1246,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	if (__nvme_poll(nvmeq, req->tag)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
-			 req->tag, nvmeq->qid);
+			 req->tag, nvmeq->cq_id);
 		return BLK_EH_HANDLED;
 	}
 
@@ -1215,7 +1259,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
+			 req->tag, nvmeq->cq_id);
 		nvme_dev_disable(dev, false);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_HANDLED;
@@ -1226,10 +1270,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
  	 * command was already aborted once before and still hasn't been
  	 * returned to the driver, or if this is the admin queue.
 	 */
-	if (!nvmeq->qid || iod->aborted) {
+	if (!nvmeq->cq_id || iod->aborted) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
-			 req->tag, nvmeq->qid);
+			 req->tag, nvmeq->cq_id);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 
@@ -1250,11 +1294,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = req->tag;
-	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
+	cmd.abort.sqid = cpu_to_le16(iod->sq_indx);
 
 	dev_warn(nvmeq->dev->ctrl.device,
 		"I/O %d QID %d timeout, aborting\n",
-		 req->tag, nvmeq->qid);
+		 req->tag, nvmeq->cq_id);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
 			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
@@ -1277,11 +1321,17 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
+	unsigned idx = 0;
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
-	if (nvmeq->sq_cmds)
-		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
-					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
+	for (idx = 0; idx < nvmeq->nr_sq; idx++) {
+		if (nvmeq->sq[idx].sq_cmds)
+			dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
+					nvmeq->sq[idx].sq_cmds,
+					nvmeq->sq[idx].sq_dma_addr);
+
+
+	}
 	kfree(nvmeq);
 }
 
@@ -1315,7 +1365,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
+	if (!nvmeq->cq_id && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
 
 	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
@@ -1367,17 +1417,18 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 }
 
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
-				int qid, int depth)
+				int sq_indx, int depth)
 {
+	int qid = nvmeq->sq[sq_indx].id;
 	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
 						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
+		nvmeq->sq[sq_indx].sq_dma_addr = dev->cmb_bus_addr + offset;
+		nvmeq->sq[sq_indx].sq_cmds_io = dev->cmb + offset;
 	} else {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
-		if (!nvmeq->sq_cmds)
+		nvmeq->sq[sq_indx].sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+					&nvmeq->sq[sq_indx].sq_dma_addr, GFP_KERNEL);
+		if (!nvmeq->sq[sq_indx].sq_cmds)
 			return -ENOMEM;
 	}
 
@@ -1385,36 +1436,51 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
-							int depth, int node)
+							int depth, int node,
+							int nr_sq)
 {
-	struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq), GFP_KERNEL,
+	struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq) + \
+				(nr_sq * sizeof(struct sq_data)), GFP_KERNEL,
 							node);
+	int cq_id, i;
 	if (!nvmeq)
 		return NULL;
-
 	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
 					  &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
-		goto free_cqdma;
+	nvmeq->nr_sq = nr_sq;
+	cq_id = (qid * nr_sq) - nr_sq + 1;
+	nvmeq->cq_id = cq_id;
+	nvmeq->cq_db = &dev->dbs[cq_idx(nvmeq->cq_id, dev->db_stride)];
+	for (i = 0; i < nr_sq; i++) {
+		nvmeq->sq[i].id = cq_id++;
+		if (nvme_alloc_sq_cmds(dev, nvmeq, i, depth))
+			goto free_cqdma;
+
+		nvmeq->sq[i].sq_db = &dev->dbs[sq_idx(nvmeq->sq[i].id, dev->db_stride)];
+	}
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->q_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
-	nvmeq->qid = qid;
 	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
 	dev->ctrl.queue_count++;
-
 	return nvmeq;
 
  free_cqdma:
+	for (i = 0; i < nr_sq; i++) {
+		if (nvmeq->sq[i].sq_cmds) {
+			dma_free_coherent(dev->dev, SQ_SIZE(depth),
+					nvmeq->sq[i].sq_cmds,
+					nvmeq->sq[i].sq_dma_addr);
+		}
+	}
 	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq->cqes,
 							nvmeq->cq_dma_addr);
  free_nvmeq:
@@ -1429,22 +1495,26 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 
 	if (use_threaded_interrupts) {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->cq_id);
 	} else {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->cq_id);
 	}
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-
+	int i;
 	spin_lock_irq(&nvmeq->q_lock);
-	nvmeq->sq_tail = 0;
+	for (i = 0; i < nvmeq->nr_sq; i++) {
+		nvmeq->sq[i].sq_tail = 0;
+		nvmeq->sq[i].sq_db = &dev->dbs[sq_idx(nvmeq->sq[i].id,
+					dev->db_stride)];
+	}
+	nvmeq->cq_db = &dev->dbs[cq_idx(nvmeq->cq_id, dev->db_stride)];
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
@@ -1454,16 +1524,16 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-	int result;
-
+	int result, i;
 	nvmeq->cq_vector = qid - 1;
-	result = adapter_alloc_cq(dev, qid, nvmeq);
+	result = adapter_alloc_cq(dev, nvmeq->cq_id, nvmeq);
 	if (result < 0)
 		return result;
-
-	result = adapter_alloc_sq(dev, qid, nvmeq);
-	if (result < 0)
-		goto release_cq;
+	for (i = 0; i < nvmeq->nr_sq; i++) {
+		result = adapter_alloc_sq(dev, i, nvmeq);
+		if (result < 0)
+			goto release_cq;
+	}
 
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
@@ -1473,9 +1543,12 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	return result;
 
  release_sq:
-	adapter_delete_sq(dev, qid);
+	while (i) {
+		adapter_delete_sq(dev, nvmeq->sq[i].id);
+		--i;
+	}
  release_cq:
-	adapter_delete_cq(dev, qid);
+	adapter_delete_cq(dev, nvmeq->cq_id);
 	return result;
 }
 
@@ -1595,7 +1668,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	nvmeq = dev->queues[0];
 	if (!nvmeq) {
 		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
-					dev_to_node(dev->dev));
+					dev_to_node(dev->dev), 1);
 		if (!nvmeq)
 			return -ENOMEM;
 	}
@@ -1604,13 +1677,12 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	aqa |= aqa << 16;
 
 	writel(aqa, dev->bar + NVME_REG_AQA);
-	lo_hi_writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
+	lo_hi_writeq(nvmeq->sq[0].sq_dma_addr, dev->bar + NVME_REG_ASQ);
 	lo_hi_writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
 
 	result = nvme_enable_ctrl(&dev->ctrl, dev->ctrl.cap);
 	if (result)
 		return result;
-
 	nvmeq->cq_vector = 0;
 	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(nvmeq);
@@ -1626,11 +1698,11 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max;
 	int ret = 0;
-
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
 		/* vector == qid - 1, match nvme_create_queue */
 		if (!nvme_alloc_queue(dev, i, dev->q_depth,
-		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
+		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1),
+				dev->sq_per_core)) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -1896,19 +1968,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, nr_io_queues;
+	int result, nr_io_sqes, nr_io_cqes;
 	unsigned long size;
 
-	nr_io_queues = num_present_cpus();
-	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
+	nr_io_sqes = num_present_cpus() * dev->sq_per_core;
+	result = nvme_set_queue_count(&dev->ctrl, &nr_io_sqes);
 	if (result < 0)
 		return result;
 
-	if (nr_io_queues == 0)
+	if (nr_io_sqes == 0)
 		return 0;
-
 	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
-		result = nvme_cmb_qdepth(dev, nr_io_queues,
+		result = nvme_cmb_qdepth(dev, nr_io_sqes,
 				sizeof(struct nvme_command));
 		if (result > 0)
 			dev->q_depth = result;
@@ -1917,14 +1988,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	do {
-		size = db_bar_size(dev, nr_io_queues);
+		size = db_bar_size(dev, nr_io_sqes);
 		result = nvme_remap_bar(dev, size);
 		if (!result)
 			break;
-		if (!--nr_io_queues)
+		nr_io_sqes -= dev->sq_per_core;
+		if (!nr_io_sqes)
 			return -ENOMEM;
 	} while (1);
-	adminq->q_db = dev->dbs;
+	adminq->sq[0].sq_db = dev->dbs;
+	adminq->cq_db = &dev->dbs[dev->db_stride];
+
+	nr_io_cqes = nr_io_sqes / dev->sq_per_core;
 
 	/* Deregister the admin queue's interrupt */
 	pci_free_irq(pdev, 0, adminq);
@@ -1934,11 +2009,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
+	nr_io_cqes = pci_alloc_irq_vectors(pdev, 1, nr_io_cqes,
 			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	if (nr_io_cqes <= 0)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
+	/*
+	 * Recalculate sqes, in case nr_io_cqes reduces due to above call
+	 */
+	nr_io_sqes = nr_io_cqes * dev->sq_per_core;
+	dev->max_qid = nr_io_cqes;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
@@ -1984,7 +2063,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 	nvme_del_queue_end(req, error);
 }
 
-static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
+static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode, u16 qid)
 {
 	struct request_queue *q = nvmeq->dev->ctrl.admin_q;
 	struct request *req;
@@ -1992,7 +2071,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.delete_queue.opcode = opcode;
-	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
+	cmd.delete_queue.qid = cpu_to_le16(qid);
 
 	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
 	if (IS_ERR(req))
@@ -2009,20 +2088,34 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 
 static void nvme_disable_io_queues(struct nvme_dev *dev, int queues)
 {
-	int pass;
+	int pass, err;
 	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
 	for (pass = 0; pass < 2; pass++) {
-		int sent = 0, i = queues;
+		int sent = 0, i = queues, j;
 
 		reinit_completion(&dev->ioq_wait);
  retry:
 		timeout = ADMIN_TIMEOUT;
-		for (; i > 0; i--, sent++)
-			if (nvme_delete_queue(dev->queues[i], opcode))
-				break;
+		if (opcode == nvme_admin_delete_cq) {
+			for (; i > 0; i--, sent++)
+				if (nvme_delete_queue(dev->queues[i], opcode,
+						dev->queues[i]->cq_id))
+					break;
+		} else {
+			for (; i > 0; i--) {
+				for (j = 0; j < dev->sq_per_core; j++) {
+					err = nvme_delete_queue(dev->queues[i],
+							opcode,
+							dev->queues[i]->sq[j].id);
+					if (err)
+						break;
+					++sent;
+				}
+			}
 
+		}
 		while (sent--) {
 			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
 			if (timeout == 0)
@@ -2106,7 +2199,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 				io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
-
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
 	 * some MacBook7,1 to avoid controller resets and data loss.
@@ -2306,6 +2398,18 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	dev->sq_per_core = SQ_PER_CORE_RR;
+	if (enable_wrr) {
+		if (NVME_CAP_WRR(dev->ctrl.cap)) {
+			dev->sq_per_core = SQ_PER_CORE_WRR;
+			dev->ctrl.ctrl_config = NVME_CC_AMS_WRRU;
+			dev_info(dev->ctrl.device,
+					"enabling wrr, %u sq per core\n",
+					dev->sq_per_core);
+		} else
+			dev_warn(dev->ctrl.device, "does not support WRR\n");
+	}
+
 	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
 		goto out;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index aea87f0d..7b33a47 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -116,6 +116,7 @@ enum {
 };
 
 #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
+#define NVME_CAP_WRR(cap)	(((cap) >> 17) & 0x1)
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
-- 
2.7.4
