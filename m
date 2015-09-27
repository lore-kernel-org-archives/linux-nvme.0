From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:53 +0200
Subject: [PATCH 05/10] nvme: switch AEN processing to use blk_execute_rq_nowait
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-6-git-send-email-hch@lst.de>

For this we add a new nvme_submit_async_cmd helper that is similar to
nvme_submit_sync_cmd, but allows finer control of the request flags and
executes the command asynchronously.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 102 ++++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ebc3138..c1745eb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -305,26 +305,6 @@ static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 	return ctx;
 }
 
-static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
-{
-	u32 result = le32_to_cpup(&cqe->result);
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-
-	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
-		++nvmeq->dev->event_limit;
-	if (status != NVME_SC_SUCCESS)
-		return;
-
-	switch (result & 0xff07) {
-	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(nvmeq->q_dmadev, "rescanning\n");
-		schedule_work(&nvmeq->dev->scan_work);
-	default:
-		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
-	}
-}
-
 static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -1057,28 +1037,76 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen, NULL, 0);
 }
 
-static int nvme_submit_async_admin_req(struct nvme_dev *dev)
+static int nvme_submit_async_cmd(struct request_queue *q,
+		struct nvme_command *cmd, unsigned long timeout, gfp_t gfp_mask,
+		bool reserved, void *end_io_data, rq_end_io_fn *done)
+		
 {
-	struct nvme_queue *nvmeq = dev->queues[0];
-	struct nvme_command c;
-	struct nvme_cmd_info *cmd_info;
+	bool write = cmd->common.opcode & 1;
 	struct request *req;
 
-	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC, true);
+	req = blk_mq_alloc_request(q, write, gfp_mask, reserved);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->cmd_flags |= REQ_NO_TIMEOUT;
-	cmd_info = blk_mq_rq_to_pdu(req);
-	nvme_set_info(cmd_info, NULL, async_req_completion);
+	req->cmd_type = REQ_TYPE_DRV_PRIV;
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	req->__data_len = 0;
+	req->__sector = (sector_t) -1;
+	req->bio = req->biotail = NULL;
+
+	if (timeout == ULONG_MAX)
+		req->cmd_flags |= REQ_NO_TIMEOUT;
+	else
+		req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+
+	req->cmd = (unsigned char *)cmd;
+	req->cmd_len = sizeof(struct nvme_command);
+	req->special = (void *)0;
+	req->end_io_data = end_io_data;
+
+	blk_execute_rq_nowait(req->q, NULL, req, 0, done);
+	return 0;
+}
+
+static void aen_endio(struct request *req, int error)
+{
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = cmd->nvmeq;
+	u32 result = (u32)(uintptr_t)req->special;
+	u16 status = req->errors;
+
+	if (status == NVME_SC_SUCCESS ||
+	    status == NVME_SC_ABORT_REQ ||
+	    status < 0)
+		++nvmeq->dev->event_limit;
+	else
+		dev_info(nvmeq->q_dmadev,
+			 "async event failed, not resubmitting.\n");
+
+	if (status != NVME_SC_SUCCESS)
+		return;
+
+	switch (result & 0xff07) {
+	case NVME_AER_NOTICE_NS_CHANGED:
+		dev_info(nvmeq->q_dmadev, "rescanning\n");
+		schedule_work(&nvmeq->dev->scan_work);
+	default:
+		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
+	}
+
+	blk_mq_free_request(req);
+}
+
+static int nvme_submit_aen(struct nvme_dev *dev)
+{
+	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = req->tag;
 
-	blk_mq_free_request(req);
-	__nvme_submit_cmd(nvmeq, &c);
-	return 0;
+	return nvme_submit_async_cmd(dev->admin_q, &c, ULONG_MAX, GFP_ATOMIC,
+			true, aen_endio, NULL);
 }
 
 static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
@@ -1699,6 +1727,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			dev->admin_q = NULL;
 			return -ENODEV;
 		}
+		dev->admin_q->queuedata = dev;
 	} else
 		blk_mq_unfreeze_queue(dev->admin_q);
 
@@ -2091,9 +2120,14 @@ static int nvme_kthread(void *data)
 				nvme_process_cq(nvmeq);
 
 				while ((i == 0) && (dev->event_limit > 0)) {
-					if (nvme_submit_async_admin_req(dev))
-						break;
 					dev->event_limit--;
+					spin_unlock_irq(&nvmeq->q_lock);
+					if (nvme_submit_aen(dev)) {
+						dev->event_limit++;
+						spin_lock_irq(&nvmeq->q_lock);
+						break;
+					}
+					spin_lock_irq(&nvmeq->q_lock);
 				}
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
-- 
1.9.1
