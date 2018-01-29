From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Jan 2018 16:59:48 -0700
Subject: [PATCH 2/3] nvme: Asynchronous driver commands API
In-Reply-To: <20180129235949.26267-1-keith.busch@intel.com>
References: <20180129235949.26267-1-keith.busch@intel.com>
Message-ID: <20180129235949.26267-2-keith.busch@intel.com>

The driver has a recurring pattern of sending internally generated
non-synchronous commands. This patch just provides a common API to reduce
the repetition.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++------------
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 27 +++++++--------------------
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ceb5d72d8c97..4bfb4ba6cd14 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -686,6 +686,22 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+int nvme_submit_async_cmd(struct request_queue *q, struct nvme_command *cmd,
+			  void *end_io_data, rq_end_io_fn *done,
+			  unsigned timeout, blk_mq_req_flags_t flags)
+{
+	struct request *req;
+
+	req = nvme_alloc_request(q, cmd, flags, NVME_QID_ANY);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->end_io_data = end_io_data;
+	blk_execute_rq_nowait(q, NULL, req, false, done);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_submit_async_cmd);
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
@@ -795,22 +811,13 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct nvme_command c;
-	struct request *rq;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_keep_alive;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &c, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
-	if (IS_ERR(rq))
-		return PTR_ERR(rq);
-
-	rq->timeout = ctrl->kato * HZ;
-	rq->end_io_data = ctrl;
-
-	blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvme_keep_alive_end_io);
-
-	return 0;
+	return nvme_submit_async_cmd(ctrl->admin_q, &c, ctrl,
+				     nvme_keep_alive_end_io, ctrl->kato * HZ,
+				     BLK_MQ_REQ_RESERVED);
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7786bc845fe..d0889dcd79d9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -389,6 +389,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
+int nvme_submit_async_cmd(struct request_queue *q, struct nvme_command *cmd,
+			  void *end_io_data, rq_end_io_fn *done,
+			  unsigned timeout, blk_mq_req_flags_t flags);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e3d7b293509..8fd0e87f0efe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1185,7 +1185,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = iod->nvmeq;
 	struct nvme_dev *dev = nvmeq->dev;
-	struct request *abort_req;
 	struct nvme_command cmd;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
@@ -1259,17 +1258,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		"I/O %d QID %d timeout, aborting\n",
 		 req->tag, nvmeq->qid);
 
-	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
-	if (IS_ERR(abort_req)) {
+	if (nvme_submit_async_cmd(dev->ctrl.admin_q, &cmd, NULL, abort_endio,
+				  ADMIN_TIMEOUT, BLK_MQ_REQ_NOWAIT)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
 
-	abort_req->timeout = ADMIN_TIMEOUT;
-	abort_req->end_io_data = NULL;
-	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
-
 	/*
 	 * The aborted req will be completed on receiving the abort req.
 	 * We enable the timer again. If hit twice, it'll cause a device reset,
@@ -1991,24 +1985,17 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 {
 	struct request_queue *q = nvmeq->dev->ctrl.admin_q;
-	struct request *req;
 	struct nvme_command cmd;
 
+	rq_end_io_fn *done = (opcode == nvme_admin_delete_cq) ?
+					nvme_del_cq_end : nvme_del_queue_end;
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->timeout = ADMIN_TIMEOUT;
-	req->end_io_data = nvmeq;
-
-	blk_execute_rq_nowait(q, NULL, req, false,
-			opcode == nvme_admin_delete_cq ?
-				nvme_del_cq_end : nvme_del_queue_end);
-	return 0;
+	return nvme_submit_async_cmd(q, &cmd, nvmeq, done, ADMIN_TIMEOUT,
+				     BLK_MQ_REQ_NOWAIT);
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
-- 
2.14.3
