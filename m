From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:19:22 -0600
Subject: [PATCHv2 3/5] nvme: Single AEN request
In-Reply-To: <20171020221924.30659-1-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
Message-ID: <20171020221924.30659-4-keith.busch@intel.com>

The driver can handle tracking only one AEN request, so this patch
removes handling for multiple ones.

Reviewed-by: James Smart  <james.smart at broadcom.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c   | 28 +++-------------------------
 drivers/nvme/host/fc.c     |  9 +++------
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    |  4 ++--
 drivers/nvme/host/rdma.c   |  5 +----
 drivers/nvme/target/loop.c |  2 +-
 6 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b7fa9ba1e22..7fb55b6e26c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2579,15 +2579,7 @@ static void nvme_async_event_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
 
-	spin_lock_irq(&ctrl->lock);
-	while (ctrl->state == NVME_CTRL_LIVE && ctrl->event_limit > 0) {
-		int aer_idx = --ctrl->event_limit;
-
-		spin_unlock_irq(&ctrl->lock);
-		ctrl->ops->submit_async_event(ctrl, aer_idx);
-		spin_lock_irq(&ctrl->lock);
-	}
-	spin_unlock_irq(&ctrl->lock);
+	ctrl->ops->submit_async_event(ctrl);
 }
 
 static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
@@ -2659,22 +2651,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	bool done = true;
 
-	switch (le16_to_cpu(status) >> 1) {
-	case NVME_SC_SUCCESS:
-		done = false;
-		/*FALLTHRU*/
-	case NVME_SC_ABORT_REQ:
-		++ctrl->event_limit;
-		if (ctrl->state == NVME_CTRL_LIVE)
-			queue_work(nvme_wq, &ctrl->async_event_work);
-		break;
-	default:
-		break;
-	}
-
-	if (done)
+	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
 	switch (result & 0xff07) {
@@ -2688,12 +2666,12 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
+	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
 void nvme_queue_async_events(struct nvme_ctrl *ctrl)
 {
-	ctrl->event_limit = NVME_AEN_COMMANDS;
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_queue_async_events);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6b8e6ec3c2ab..285e0579bbef 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2165,7 +2165,7 @@ nvme_fc_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 }
 
 static void
-nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
+nvme_fc_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(arg);
 	struct nvme_fc_fcp_op *aen_op;
@@ -2173,9 +2173,6 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	bool terminating = false;
 	blk_status_t ret;
 
-	if (aer_idx > NVME_AEN_COMMANDS)
-		return;
-
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->flags & FCCTRL_TERMIO)
 		terminating = true;
@@ -2184,13 +2181,13 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	if (terminating)
 		return;
 
-	aen_op = &ctrl->aen_ops[aer_idx];
+	aen_op = &ctrl->aen_ops[0];
 
 	ret = nvme_fc_start_fcp_op(ctrl, aen_op->queue, aen_op, 0,
 					NVMEFC_FCP_NODATA);
 	if (ret)
 		dev_err(ctrl->ctrl.device,
-			"failed async event work [%d]\n", aer_idx);
+			"failed async event work\n");
 }
 
 static void
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 331d91d5e191..2f1e52131430 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -160,7 +160,6 @@ struct nvme_ctrl {
 	u16 nssa;
 	u16 nr_streams;
 	atomic_t abort_limit;
-	u8 event_limit;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -234,7 +233,7 @@ struct nvme_ctrl_ops {
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
-	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
+	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	int (*reinit_request)(void *data, struct request *rq);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 52422c3a106f..73cb97e2121e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1043,7 +1043,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return __nvme_poll(nvmeq, tag);
 }
 
-static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
+static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = dev->queues[0];
@@ -1051,7 +1051,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH + aer_idx;
+	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	__nvme_submit_cmd(nvmeq, &c);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f35992b1c48b..9b610ba22eb9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1294,7 +1294,7 @@ static struct blk_mq_tags *nvme_rdma_tagset(struct nvme_rdma_queue *queue)
 	return queue->ctrl->tag_set.tags[queue_idx - 1];
 }
 
-static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
+static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(arg);
 	struct nvme_rdma_queue *queue = &ctrl->queues[0];
@@ -1304,9 +1304,6 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	struct ib_sge sge;
 	int ret;
 
-	if (WARN_ON_ONCE(aer_idx != 0))
-		return;
-
 	ib_dma_sync_single_for_cpu(dev, sqe->dma, sizeof(*cmd), DMA_TO_DEVICE);
 
 	memset(cmd, 0, sizeof(*cmd));
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index fc2856943d89..2b6c75d66def 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -185,7 +185,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
+static void nvme_loop_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(arg);
 	struct nvme_loop_queue *queue = &ctrl->queues[0];
-- 
2.13.6
