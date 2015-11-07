From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:45:00 +0100
Subject: [PATCH 06/12] nvme: switch abort to blk_execute_rq_nowait
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-7-git-send-email-hch@lst.de>

And remove the new unused nvme_submit_cmd helper.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c |  8 +++---
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/pci.c  | 66 ++++++++++++++++++++----------------------------
 3 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37f7d69..3600a0c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -86,12 +86,12 @@ void nvme_requeue_req(struct request *req)
 }
 
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd)
+		struct nvme_command *cmd, bool nowait)
 {
 	bool write = cmd->common.opcode & 1;
 	struct request *req;
 
-	req = blk_mq_alloc_request(q, write, GFP_KERNEL, false);
+	req = blk_mq_alloc_request(q, write, GFP_KERNEL, nowait);
 	if (IS_ERR(req))
 		return req;
 
@@ -118,7 +118,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd);
+	req = nvme_alloc_request(q, cmd, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -158,7 +158,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd);
+	req = nvme_alloc_request(q, cmd, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 58d36e7..d72bbe0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -207,7 +207,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 void nvme_requeue_req(struct request *req);
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd);
+		struct nvme_command *cmd, bool nowait);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 06fe22d..cced2e6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -374,20 +374,6 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 	}
 }
 
-static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
-{
-	struct request *req = ctx;
-
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-	u32 result = le32_to_cpup(&cqe->result);
-
-	blk_mq_free_request(req);
-
-	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
-	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
-}
-
 static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 				  unsigned int tag)
 {
@@ -417,7 +403,7 @@ static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
 }
 
 /**
- * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
+ * __nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
  * @cmd: The command to send
  *
@@ -439,14 +425,6 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 	nvmeq->sq_tail = tail;
 }
 
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&nvmeq->q_lock, flags);
-	__nvme_submit_cmd(nvmeq, cmd);
-	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
-}
-
 static __le64 **iod_list(struct nvme_iod *iod)
 {
 	return ((void *)iod) + iod->offset;
@@ -1019,13 +997,25 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
+static void abort_endio(struct request *req, int error)
+{
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = cmd->nvmeq;
+	u32 result = (u32)(uintptr_t)req->special;
+	u16 status = req->errors;
+
+	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
+	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
+
+	blk_mq_free_request(req);
+}
+
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = cmd_rq->nvmeq;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
-	struct nvme_cmd_info *abort_cmd;
 	struct nvme_command cmd;
 
 	/*
@@ -1047,27 +1037,25 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	if (atomic_dec_and_test(&dev->ctrl.abort_limit))
 		return BLK_EH_RESET_TIMER;
 
-	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, WRITE, GFP_ATOMIC,
-									false);
-	if (IS_ERR(abort_req)) {
-		atomic_inc(&dev->ctrl.abort_limit);
-		return BLK_EH_RESET_TIMER;
-	}
-
-	abort_cmd = blk_mq_rq_to_pdu(abort_req);
-	nvme_set_info(abort_cmd, abort_req, abort_completion);
-
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = req->tag;
 	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
-	cmd.abort.command_id = abort_req->tag;
-
-	cmd_rq->aborted = 1;
 
 	dev_warn(nvmeq->q_dmadev, "I/O %d QID %d timeout, aborting\n",
 				 req->tag, nvmeq->qid);
-	nvme_submit_cmd(dev->queues[0], &cmd);
+
+	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd, true);
+	if (IS_ERR(abort_req)) {
+		atomic_inc(&dev->ctrl.abort_limit);
+		return BLK_EH_RESET_TIMER;
+	}
+
+	cmd_rq->aborted = 1;
+
+	abort_req->timeout = ADMIN_TIMEOUT;
+	abort_req->end_io_data = NULL;
+	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
@@ -1948,7 +1936,7 @@ static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
 
 	init_kthread_work(&nvmeq->cmdinfo.work, fn);
 
-	req = nvme_alloc_request(nvmeq->dev->ctrl.admin_q, &c);
+	req = nvme_alloc_request(nvmeq->dev->ctrl.admin_q, &c, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-- 
1.9.1
