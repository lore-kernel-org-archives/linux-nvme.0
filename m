From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:45:01 +0100
Subject: [PATCH 07/12] nvme: special case AEN requests
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-8-git-send-email-hch@lst.de>

AEN requests are different from other requests in that they don't time out
or can easily be cancelled.  Because of that we should not use the blk-mq
infrastructure but just special case them in the completion path.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cced2e6..344aa6e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -45,6 +45,7 @@
 
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
+#define NVME_NR_AEN_COMMANDS	1
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
@@ -354,23 +355,22 @@ static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 	return ctx;
 }
 
-static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
+static void nvme_finish_aen_cmd(struct nvme_dev *dev, struct nvme_completion *cqe)
 {
-	u32 result = le32_to_cpup(&cqe->result);
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	u16 status = le16_to_cpu(cqe->status) >> 1;
+	u32 result = le32_to_cpu(cqe->result);
 
 	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
-		++nvmeq->dev->ctrl.event_limit;
+		++dev->ctrl.event_limit;
 	if (status != NVME_SC_SUCCESS)
 		return;
 
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(nvmeq->q_dmadev, "rescanning\n");
-		queue_work(nvme_workq, &nvmeq->dev->scan_work);
+		dev_info(dev->dev, "rescanning\n");
+		queue_work(nvme_workq, &dev->scan_work);
 	default:
-		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
+		dev_warn(dev->dev, "async event result %08x\n", result);
 	}
 }
 
@@ -852,13 +852,28 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 		void *ctx;
 		nvme_completion_fn fn;
 		struct nvme_completion cqe = nvmeq->cqes[head];
-		if ((le16_to_cpu(cqe.status) & 1) != phase)
+		u16 status = le16_to_cpu(cqe.status);
+
+		if ((status & 1) != phase)
 			break;
 		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
 		if (++head == nvmeq->q_depth) {
 			head = 0;
 			phase = !phase;
 		}
+
+		/*
+		 * AEN requests are special as they don't time out and can
+		 * survive any kind of queue freeze and often don't respond to
+		 * aborts.  We don't even bother to allocate a struct request
+		 * for them but rather special case them here.
+		 */
+		if (unlikely(nvmeq->qid == 0 &&
+				cqe.command_id < NVME_NR_AEN_COMMANDS)) {
+			nvme_finish_aen_cmd(nvmeq->dev, &cqe);
+			continue;
+		}
+
 		ctx = nvme_finish_cmd(nvmeq, cqe.command_id, &fn);
 		fn(nvmeq, ctx, &cqe);
 	}
@@ -901,28 +916,14 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-static int nvme_submit_async_admin_req(struct nvme_dev *dev)
+static void nvme_submit_async_admin_req(struct nvme_dev *dev)
 {
-	struct nvme_queue *nvmeq = dev->queues[0];
 	struct nvme_command c;
-	struct nvme_cmd_info *cmd_info;
-	struct request *req;
-
-	req = blk_mq_alloc_request(dev->ctrl.admin_q, WRITE, GFP_ATOMIC, true);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->cmd_flags |= REQ_NO_TIMEOUT;
-	cmd_info = blk_mq_rq_to_pdu(req);
-	nvme_set_info(cmd_info, NULL, async_req_completion);
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = req->tag;
 
-	blk_mq_free_request(req);
-	__nvme_submit_cmd(nvmeq, &c);
-	return 0;
+	__nvme_submit_cmd(dev->queues[0], &c);
 }
 
 static void async_cmd_info_endio(struct request *req, int error)
@@ -1409,7 +1410,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
 		dev->admin_tagset.nr_hw_queues = 1;
 		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
-		dev->admin_tagset.reserved_tags = 1;
+		dev->admin_tagset.reserved_tags = NVME_NR_AEN_COMMANDS;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
@@ -1543,8 +1544,7 @@ static int nvme_kthread(void *data)
 				nvme_process_cq(nvmeq);
 
 				while (i == 0 && dev->ctrl.event_limit > 0) {
-					if (nvme_submit_async_admin_req(dev))
-						break;
+					nvme_submit_async_admin_req(dev);
 					dev->ctrl.event_limit--;
 				}
 				spin_unlock_irq(&nvmeq->q_lock);
@@ -2198,7 +2198,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto free_tags;
 
-	dev->ctrl.event_limit = 1;
+	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
 
 	result = nvme_dev_list_add(dev);
 	if (result)
-- 
1.9.1
