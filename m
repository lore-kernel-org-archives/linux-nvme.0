From: eliezer.tamir@linux.intel.com (Eliezer Tamir)
Date: Tue, 17 Nov 2015 16:48:17 +0200
Subject: [RFC PATCH] nvme: add HW API tags
Message-ID: <20151117144817.90025.53888.stgit@coronium.jer.intel.com>

The purpose of this RFC patch is to seek feedback on the way we want
to tag upstream driver functions for silicon validation use.

These tags are used by pre-silicon HW testing, marking functions that
access the HW. They are defined out for normal driver compilation.
(this patch applies to Linus' master)

Signed-off-by: Eliezer Tamir <eliezer.tamir at linux.intel.com>
---
 drivers/nvme/host/pci.c |  189 ++++++++++++++++++++++++-----------------------
 1 file changed, 97 insertions(+), 92 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8187df2..c1802e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -47,6 +47,11 @@
 #include <uapi/linux/nvme_ioctl.h>
 #include "nvme.h"
 
+/* tags used by HW validation tests */
+#ifndef HWAPI
+#define hwapi
+#endif
+
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
@@ -171,13 +176,13 @@ struct nvme_cmd_info {
  * as it only leads to a small amount of wasted memory for the lifetime of
  * the I/O.
  */
-static int nvme_npages(unsigned size, struct nvme_dev *dev)
+static hwapi int nvme_npages(unsigned size, struct nvme_dev *dev)
 {
 	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
 
-static unsigned int nvme_cmd_size(struct nvme_dev *dev)
+static hwapi unsigned int nvme_cmd_size(struct nvme_dev *dev)
 {
 	unsigned int ret = sizeof(struct nvme_cmd_info);
 
@@ -250,7 +255,7 @@ static int nvme_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
+static hwapi void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
 				nvme_completion_fn handler)
 {
 	cmd->fn = handler;
@@ -259,7 +264,7 @@ static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
 	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
 }
 
-static void *iod_get_private(struct nvme_iod *iod)
+static hwapi void *iod_get_private(struct nvme_iod *iod)
 {
 	return (void *) (iod->private & ~0x1UL);
 }
@@ -267,7 +272,7 @@ static void *iod_get_private(struct nvme_iod *iod)
 /*
  * If bit 0 is set, the iod is embedded in the request payload.
  */
-static bool iod_should_kfree(struct nvme_iod *iod)
+static hwapi bool iod_should_kfree(struct nvme_iod *iod)
 {
 	return (iod->private & NVME_INT_MASK) == 0;
 }
@@ -278,7 +283,7 @@ static bool iod_should_kfree(struct nvme_iod *iod)
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 
-static void special_completion(struct nvme_queue *nvmeq, void *ctx,
+static hwapi void special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	if (ctx == CMD_CTX_CANCELLED)
@@ -298,7 +303,7 @@ static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);
 }
 
-static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
+static hwapi void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 {
 	void *ctx;
 
@@ -310,7 +315,7 @@ static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 	return ctx;
 }
 
-static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
+static hwapi void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	u32 result = le32_to_cpup(&cqe->result);
@@ -330,7 +335,7 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 	}
 }
 
-static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
+static hwapi void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct request *req = ctx;
@@ -344,7 +349,7 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 	++nvmeq->dev->abort_limit;
 }
 
-static void async_completion(struct nvme_queue *nvmeq, void *ctx,
+static hwapi void async_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct async_cmd_info *cmdinfo = ctx;
@@ -354,7 +359,7 @@ static void async_completion(struct nvme_queue *nvmeq, void *ctx,
 	blk_mq_free_request(cmdinfo->req);
 }
 
-static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
+static hwapi inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 				  unsigned int tag)
 {
 	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, tag);
@@ -365,7 +370,7 @@ static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 /*
  * Called with local interrupts disabled and the q_lock held.  May not sleep.
  */
-static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
+static hwapi void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
 						nvme_completion_fn *fn)
 {
 	struct nvme_cmd_info *cmd = get_cmd_from_tag(nvmeq, tag);
@@ -389,7 +394,7 @@ static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
  *
  * Safe to use from interrupt context
  */
-static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
+static hwapi void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 						struct nvme_command *cmd)
 {
 	u16 tail = nvmeq->sq_tail;
@@ -405,7 +410,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 	nvmeq->sq_tail = tail;
 }
 
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
+static hwapi void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&nvmeq->q_lock, flags);
@@ -413,12 +418,12 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
 }
 
-static __le64 **iod_list(struct nvme_iod *iod)
+static hwapi __le64 **iod_list(struct nvme_iod *iod)
 {
 	return ((void *)iod) + iod->offset;
 }
 
-static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
+static hwapi inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
 			    unsigned nseg, unsigned long private)
 {
 	iod->private = private;
@@ -428,7 +433,7 @@ static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
 	iod->nents = 0;
 }
 
-static struct nvme_iod *
+static hwapi struct nvme_iod *
 __nvme_alloc_iod(unsigned nseg, unsigned bytes, struct nvme_dev *dev,
 		 unsigned long priv, gfp_t gfp)
 {
@@ -442,7 +447,7 @@ __nvme_alloc_iod(unsigned nseg, unsigned bytes, struct nvme_dev *dev,
 	return iod;
 }
 
-static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
+static hwapi struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 			               gfp_t gfp)
 {
 	unsigned size = !(rq->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(rq) :
@@ -463,7 +468,7 @@ static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 				(unsigned long) rq, gfp);
 }
 
-static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
+static hwapi void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 {
 	const int last_prp = dev->page_size / 8 - 1;
 	int i;
@@ -483,7 +488,7 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 		kfree(iod);
 }
 
-static int nvme_error_status(u16 status)
+static hwapi int nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
@@ -586,7 +591,7 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 }
 #endif
 
-static void req_completion(struct nvme_queue *nvmeq, void *ctx,
+static hwapi void req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct nvme_iod *iod = ctx;
@@ -648,7 +653,7 @@ release_iod:
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
-static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
+static hwapi int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 		int total_len, gfp_t gfp)
 {
 	struct dma_pool *pool;
@@ -727,7 +732,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 	return total_len;
 }
 
-static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
+static hwapi void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
 		struct nvme_iod *iod)
 {
 	struct nvme_command cmnd;
@@ -747,7 +752,7 @@ static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
  * worth having a special pool for these or additional cases to handle freeing
  * the iod.
  */
-static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
+static hwapi void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		struct request *req, struct nvme_iod *iod)
 {
 	struct nvme_dsm_range *range =
@@ -769,7 +774,7 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	__nvme_submit_cmd(nvmeq, &cmnd);
 }
 
-static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
+static hwapi void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 								int cmdid)
 {
 	struct nvme_command cmnd;
@@ -782,7 +787,7 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	__nvme_submit_cmd(nvmeq, &cmnd);
 }
 
-static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
+static hwapi int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
 	struct request *req = iod_get_private(iod);
@@ -838,7 +843,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 /*
  * NOTE: ns is NULL when called on the admin queue.
  */
-static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+static hwapi int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
 	struct nvme_ns *ns = hctx->queue->queuedata;
@@ -935,7 +940,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_BUSY;
 }
 
-static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
+static hwapi void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
 	u16 head, phase;
 
@@ -980,7 +985,7 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
 	__nvme_process_cq(nvmeq, NULL);
 }
 
-static irqreturn_t nvme_irq(int irq, void *data)
+static hwapi irqreturn_t nvme_irq(int irq, void *data)
 {
 	irqreturn_t result;
 	struct nvme_queue *nvmeq = data;
@@ -992,7 +997,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return result;
 }
 
-static irqreturn_t nvme_irq_check(int irq, void *data)
+static hwapi irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
@@ -1001,7 +1006,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static hwapi int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
@@ -1022,7 +1027,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
+hwapi int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, void __user *ubuffer, unsigned bufflen,
 		u32 *result, unsigned timeout)
 {
@@ -1071,13 +1076,13 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	return ret;
 }
 
-int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
+hwapi int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen, NULL, 0);
 }
 
-static int nvme_submit_async_admin_req(struct nvme_dev *dev)
+static hwapi int nvme_submit_async_admin_req(struct nvme_dev *dev)
 {
 	struct nvme_queue *nvmeq = dev->queues[0];
 	struct nvme_command c;
@@ -1101,7 +1106,7 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
+static hwapi int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
 			struct nvme_command *cmd,
 			struct async_cmd_info *cmdinfo, unsigned timeout)
 {
@@ -1125,7 +1130,7 @@ static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
 	return 0;
 }
 
-static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
+static hwapi int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	struct nvme_command c;
 
@@ -1136,7 +1141,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
 }
 
-static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
+static hwapi int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
 	struct nvme_command c;
@@ -1157,7 +1162,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
 }
 
-static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
+static hwapi int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
 	struct nvme_command c;
@@ -1178,17 +1183,17 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
 }
 
-static int adapter_delete_cq(struct nvme_dev *dev, u16 cqid)
+static hwapi int adapter_delete_cq(struct nvme_dev *dev, u16 cqid)
 {
 	return adapter_delete_queue(dev, nvme_admin_delete_cq, cqid);
 }
 
-static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
+static hwapi int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 {
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
-int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id)
+hwapi int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
 	int error;
@@ -1208,7 +1213,7 @@ int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
-int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
+hwapi int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
 		struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
@@ -1229,7 +1234,7 @@ int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
 	return error;
 }
 
-int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
+hwapi int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
@@ -1244,7 +1249,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 			result, 0);
 }
 
-int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
+hwapi int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
@@ -1259,7 +1264,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 			result, 0);
 }
 
-int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log)
+hwapi int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log)
 {
 	struct nvme_command c = { };
 	int error;
@@ -1287,7 +1292,7 @@ int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log)
  * Schedule controller reset if the command was already aborted once before and
  * still hasn't been returned to the driver, or if this is the admin queue.
  */
-static void nvme_abort_req(struct request *req)
+static hwapi void nvme_abort_req(struct request *req)
 {
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = cmd_rq->nvmeq;
@@ -1332,7 +1337,7 @@ static void nvme_abort_req(struct request *req)
 	nvme_submit_cmd(dev->queues[0], &cmd);
 }
 
-static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
+static hwapi void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
 {
 	struct nvme_queue *nvmeq = data;
 	void *ctx;
@@ -1379,7 +1384,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_free_queue(struct nvme_queue *nvmeq)
+static hwapi void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
@@ -1389,7 +1394,7 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 	kfree(nvmeq);
 }
 
-static void nvme_free_queues(struct nvme_dev *dev, int lowest)
+static hwapi void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
 	int i;
 
@@ -1405,7 +1410,7 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
  * nvme_suspend_queue - put queue into suspended state
  * @nvmeq - queue to suspend
  */
-static int nvme_suspend_queue(struct nvme_queue *nvmeq)
+static hwapi int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
 	int vector;
 
@@ -1428,7 +1433,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	return 0;
 }
 
-static void nvme_clear_queue(struct nvme_queue *nvmeq)
+static hwapi void nvme_clear_queue(struct nvme_queue *nvmeq)
 {
 	spin_lock_irq(&nvmeq->q_lock);
 	if (nvmeq->tags && *nvmeq->tags)
@@ -1436,7 +1441,7 @@ static void nvme_clear_queue(struct nvme_queue *nvmeq)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static void nvme_disable_queue(struct nvme_dev *dev, int qid)
+static hwapi void nvme_disable_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
 
@@ -1457,7 +1462,7 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
+static hwapi int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 				int entry_size)
 {
 	int q_depth = dev->q_depth;
@@ -1480,7 +1485,7 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 	return q_depth;
 }
 
-static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
+static hwapi int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				int qid, int depth)
 {
 	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
@@ -1498,7 +1503,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	return 0;
 }
 
-static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
+static hwapi struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth)
 {
 	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
@@ -1551,7 +1556,7 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				IRQF_SHARED, name, nvmeq);
 }
 
-static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+static hwapi void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
@@ -1565,7 +1570,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
+static hwapi int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
@@ -1593,7 +1598,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	return result;
 }
 
-static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
+static hwapi int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
 {
 	unsigned long timeout;
 	u32 bit = enabled ? NVME_CSTS_RDY : 0;
@@ -1621,7 +1626,7 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
  * bits', but doing so may cause the device to complete commands to the
  * admin queue ... and we don't know what memory that might be pointing at!
  */
-static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
+static hwapi int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 {
 	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
 	dev->ctrl_config &= ~NVME_CC_ENABLE;
@@ -1630,7 +1635,7 @@ static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 	return nvme_wait_ready(dev, cap, false);
 }
 
-static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
+static hwapi int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 {
 	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
 	dev->ctrl_config |= NVME_CC_ENABLE;
@@ -1639,7 +1644,7 @@ static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 	return nvme_wait_ready(dev, cap, true);
 }
 
-static int nvme_shutdown_ctrl(struct nvme_dev *dev)
+static hwapi int nvme_shutdown_ctrl(struct nvme_dev *dev)
 {
 	unsigned long timeout;
 
@@ -1682,7 +1687,7 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.poll		= nvme_poll,
 };
 
-static void nvme_dev_remove_admin(struct nvme_dev *dev)
+static hwapi void nvme_dev_remove_admin(struct nvme_dev *dev)
 {
 	if (dev->admin_q && !blk_queue_dying(dev->admin_q)) {
 		blk_cleanup_queue(dev->admin_q);
@@ -1690,7 +1695,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 	}
 }
 
-static int nvme_alloc_admin_tags(struct nvme_dev *dev)
+static hwapi int nvme_alloc_admin_tags(struct nvme_dev *dev)
 {
 	if (!dev->admin_q) {
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
@@ -1721,7 +1726,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_configure_admin_queue(struct nvme_dev *dev)
+static hwapi int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
 	u32 aqa;
@@ -2195,7 +2200,7 @@ static const struct block_device_operations nvme_fops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static int nvme_kthread(void *data)
+static hwapi int nvme_kthread(void *data)
 {
 	struct nvme_dev *dev, *next;
 
@@ -2327,7 +2332,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
  * admin commands.  This might be useful to upgrade a buggy firmware
  * for example.
  */
-static void nvme_create_io_queues(struct nvme_dev *dev)
+static hwapi void nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i;
 
@@ -2342,7 +2347,7 @@ static void nvme_create_io_queues(struct nvme_dev *dev)
 		}
 }
 
-static int set_queue_count(struct nvme_dev *dev, int count)
+static hwapi int set_queue_count(struct nvme_dev *dev, int count)
 {
 	int status;
 	u32 result;
@@ -2581,7 +2586,7 @@ static void nvme_set_irq_hints(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_scan(struct work_struct *work)
+static hwapi void nvme_dev_scan(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
 	struct nvme_id_ctrl *ctrl;
@@ -2601,7 +2606,7 @@ static void nvme_dev_scan(struct work_struct *work)
  * namespaces failed.  At the moment, these failures are silent.  TBD which
  * failures should be reported.
  */
-static int nvme_dev_add(struct nvme_dev *dev)
+static hwapi int nvme_dev_add(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int res;
@@ -2656,7 +2661,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_dev_map(struct nvme_dev *dev)
+static hwapi int nvme_dev_map(struct nvme_dev *dev)
 {
 	u64 cap;
 	int bars, result = -ENOMEM;
@@ -2741,7 +2746,7 @@ struct nvme_delq_ctx {
 	atomic_t refcount;
 };
 
-static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
+static hwapi void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 {
 	dq->waiter = current;
 	mb();
@@ -2770,26 +2775,26 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 	set_current_state(TASK_RUNNING);
 }
 
-static void nvme_put_dq(struct nvme_delq_ctx *dq)
+static hwapi void nvme_put_dq(struct nvme_delq_ctx *dq)
 {
 	atomic_dec(&dq->refcount);
 	if (dq->waiter)
 		wake_up_process(dq->waiter);
 }
 
-static struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
+static hwapi struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
 {
 	atomic_inc(&dq->refcount);
 	return dq;
 }
 
-static void nvme_del_queue_end(struct nvme_queue *nvmeq)
+static hwapi void nvme_del_queue_end(struct nvme_queue *nvmeq)
 {
 	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
 	nvme_put_dq(dq);
 }
 
-static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
+static hwapi int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
 						kthread_work_func_t fn)
 {
 	struct nvme_command c;
@@ -2803,20 +2808,20 @@ static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
 								ADMIN_TIMEOUT);
 }
 
-static void nvme_del_cq_work_handler(struct kthread_work *work)
+static hwapi void nvme_del_cq_work_handler(struct kthread_work *work)
 {
 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
 							cmdinfo.work);
 	nvme_del_queue_end(nvmeq);
 }
 
-static int nvme_delete_cq(struct nvme_queue *nvmeq)
+static hwapi int nvme_delete_cq(struct nvme_queue *nvmeq)
 {
 	return adapter_async_del_queue(nvmeq, nvme_admin_delete_cq,
 						nvme_del_cq_work_handler);
 }
 
-static void nvme_del_sq_work_handler(struct kthread_work *work)
+static hwapi void nvme_del_sq_work_handler(struct kthread_work *work)
 {
 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
 							cmdinfo.work);
@@ -2828,13 +2833,13 @@ static void nvme_del_sq_work_handler(struct kthread_work *work)
 		nvme_del_queue_end(nvmeq);
 }
 
-static int nvme_delete_sq(struct nvme_queue *nvmeq)
+static hwapi int nvme_delete_sq(struct nvme_queue *nvmeq)
 {
 	return adapter_async_del_queue(nvmeq, nvme_admin_delete_sq,
 						nvme_del_sq_work_handler);
 }
 
-static void nvme_del_queue_start(struct kthread_work *work)
+static hwapi void nvme_del_queue_start(struct kthread_work *work)
 {
 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
 							cmdinfo.work);
@@ -2842,7 +2847,7 @@ static void nvme_del_queue_start(struct kthread_work *work)
 		nvme_del_queue_end(nvmeq);
 }
 
-static void nvme_disable_io_queues(struct nvme_dev *dev)
+static hwapi void nvme_disable_io_queues(struct nvme_dev *dev)
 {
 	int i;
 	DEFINE_KTHREAD_WORKER_ONSTACK(worker);
@@ -2879,7 +2884,7 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 * Remove the node from the device list and check
 * for whether or not we need to stop the nvme_thread.
 */
-static void nvme_dev_list_remove(struct nvme_dev *dev)
+static hwapi void nvme_dev_list_remove(struct nvme_dev *dev)
 {
 	struct task_struct *tmp = NULL;
 
@@ -2895,7 +2900,7 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 		kthread_stop(tmp);
 }
 
-static void nvme_freeze_queues(struct nvme_dev *dev)
+static hwapi void nvme_freeze_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
@@ -2911,7 +2916,7 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_unfreeze_queues(struct nvme_dev *dev)
+static hwapi void nvme_unfreeze_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
@@ -2923,7 +2928,7 @@ static void nvme_unfreeze_queues(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_shutdown(struct nvme_dev *dev)
+static hwapi void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
 	u32 csts = -1;
@@ -2950,7 +2955,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 		nvme_clear_queue(dev->queues[i]);
 }
 
-static void nvme_dev_remove(struct nvme_dev *dev)
+static hwapi void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
@@ -3089,7 +3094,7 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
-static void nvme_probe_work(struct work_struct *work)
+static hwapi void nvme_probe_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
 	bool start_thread = false;
@@ -3185,7 +3190,7 @@ static void nvme_dead_ctrl(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_reset_work(struct work_struct *ws)
+static hwapi void nvme_reset_work(struct work_struct *ws)
 {
 	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
 	bool in_probe = work_busy(&dev->probe_work);
@@ -3207,7 +3212,7 @@ static void nvme_reset_work(struct work_struct *ws)
 	schedule_work(&dev->probe_work);
 }
 
-static int __nvme_reset(struct nvme_dev *dev)
+static hwapi int __nvme_reset(struct nvme_dev *dev)
 {
 	if (work_pending(&dev->reset_work))
 		return -EBUSY;
@@ -3216,7 +3221,7 @@ static int __nvme_reset(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_reset(struct nvme_dev *dev)
+static hwapi int nvme_reset(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -3368,7 +3373,7 @@ static void nvme_remove(struct pci_dev *pdev)
 #define nvme_error_resume NULL
 
 #ifdef CONFIG_PM_SLEEP
-static int nvme_suspend(struct device *dev)
+static hwapi int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
@@ -3377,7 +3382,7 @@ static int nvme_suspend(struct device *dev)
 	return 0;
 }
 
-static int nvme_resume(struct device *dev)
+static hwapi int nvme_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
