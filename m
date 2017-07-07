From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:22:59 -0400
Subject: [PATCH 5/7] nvme: Only one AEN request
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-6-git-send-email-keith.busch@intel.com>

This driver issues only one AEN request, so all the logic to handle
multiple ones is unnecessary. Even if we did allow multiple ones, the
implementation is broken as it will create command id collisions. For
those two reasons, this patch deletes all the aer index usage, assuming
there's only one.

As a consequence of removing the event limit, the core's callback for
these events is simplified to only handle the successful case. The
"abort" status handling for AER has been broken for some time anyway:
it was meant to reclaim the aer count from a driver cancelled command
after a reset, but that was relying on blk-mq to manage the reserved
tags. We don't use blk-mq tags for AER, though, so we will never see a
synthesized abort status.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c   | 27 +++------------------------
 drivers/nvme/host/fc.c     |  5 +----
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    |  4 ++--
 drivers/nvme/host/rdma.c   |  5 +----
 drivers/nvme/target/loop.c |  2 +-
 6 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb96f4a..bfd0045 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2512,36 +2512,15 @@ static void nvme_async_event_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
 
-	spin_lock_irq(&ctrl->lock);
-	while (ctrl->event_limit > 0) {
-		int aer_idx = --ctrl->event_limit;
-
-		spin_unlock_irq(&ctrl->lock);
-		ctrl->ops->submit_async_event(ctrl, aer_idx);
-		spin_lock_irq(&ctrl->lock);
-	}
-	spin_unlock_irq(&ctrl->lock);
+	ctrl->ops->submit_async_event(ctrl);
 }
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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
-		queue_work(nvme_wq, &ctrl->async_event_work);
-		break;
-	default:
-		break;
-	}
-
-	if (done)
+	if ((le16_to_cpu(status) >> 1) != NVME_SC_SUCCESS)
 		return;
 
 	switch (result & 0xff07) {
@@ -2552,12 +2531,12 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
+	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
 void nvme_queue_async_events(struct nvme_ctrl *ctrl)
 {
-	ctrl->event_limit = NVME_NR_AERS;
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_queue_async_events);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 753761c..f1ac8c0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2010,15 +2010,12 @@ nvme_fc_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 }
 
 static void
-nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
+nvme_fc_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(arg);
 	unsigned long flags;
 	bool terminating = false;
 
-	if (aer_idx > NVME_NR_AERS)
-		return;
-
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->flags & FCCTRL_TERMIO)
 		terminating = true;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0510a33..edca92d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -153,7 +153,6 @@ struct nvme_ctrl {
 	u16 nssa;
 	u16 nr_streams;
 	atomic_t abort_limit;
-	u8 event_limit;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -226,7 +225,7 @@ struct nvme_ctrl_ops {
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
-	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
+	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 };
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bd49b2..a4e3261 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -846,7 +846,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return __nvme_poll(nvmeq, tag);
 }
 
-static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
+static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = dev->queues[0];
@@ -854,7 +854,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = NVME_AQ_BLKMQ_DEPTH + aer_idx;
+	c.common.command_id = NVME_AQ_BLKMQ_DEPTH;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	__nvme_submit_cmd(nvmeq, &c);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d811f4..f739540 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1091,7 +1091,7 @@ static struct blk_mq_tags *nvme_rdma_tagset(struct nvme_rdma_queue *queue)
 	return queue->ctrl->tag_set.tags[queue_idx - 1];
 }
 
-static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
+static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(arg);
 	struct nvme_rdma_queue *queue = &ctrl->queues[0];
@@ -1101,9 +1101,6 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	struct ib_sge sge;
 	int ret;
 
-	if (WARN_ON_ONCE(aer_idx != 0))
-		return;
-
 	ib_dma_sync_single_for_cpu(dev, sqe->dma, sizeof(*cmd), DMA_TO_DEVICE);
 
 	memset(cmd, 0, sizeof(*cmd));
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 336e46e..af0d188 100644
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
2.5.5
